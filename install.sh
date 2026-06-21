#!/usr/bin/env bash
# Fail loud: a bootstrap installer should stop at the first real failure so
# you fix it and re-run. `dot` already makes every step idempotent enough
# that re-running is cheap.
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

info() { echo "[INFO] $*"; }
warn() { echo "[WARN] $*"; }
error() { echo "[ERROR] $*" >&2; exit 1; }

# Clone a git repo into $1 if $1 is not already a directory. $3 is an optional
# human-readable name for logs (defaults to the path). All "install X if
# missing" steps funnel through here.
clone_if_missing() {
    local dir="$1" url="$2" name="${3:-$1}"
    if [[ -d "$dir" ]]; then
        info "$name already installed"
        return 0
    fi
    info "Installing $name..."
    git clone "$url" "$dir"
}

# Install Homebrew if not present
install_homebrew() {
    if ! command -v brew &>/dev/null; then
        info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        info "Homebrew already installed"
    fi
}

# Install packages from Brewfile. `brew bundle` is idempotent: re-running this
# script retries anything that previously failed, so there's no need to track
# failures separately.
install_packages() {
    info "Installing packages from Brewfile..."
    # --no-lock: we don't pin versions here, so don't commit a Brewfile.lock.
    brew bundle install --no-lock --file="$DOTFILES_DIR/Brewfile"
}

# Install Oh My Zsh. We clone the repo directly rather than running omz's own
# installer: that script also edits ~/.zshrc, which we manage via stow. A plain
# clone gives us the framework + custom dir without that side effect.
install_oh_my_zsh() {
    clone_if_missing "$HOME/.oh-my-zsh" \
        https://github.com/ohmyzsh/ohmyzsh.git "Oh My Zsh"
}

# Install zsh plugins into the oh-my-zsh custom dir
install_zsh_plugins() {
    local zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
    clone_if_missing "$zsh_custom/plugins/zsh-autosuggestions" \
        https://github.com/zsh-users/zsh-autosuggestions "zsh-autosuggestions"
    clone_if_missing "$zsh_custom/plugins/zsh-syntax-highlighting" \
        https://github.com/zsh-users/zsh-syntax-highlighting.git "zsh-syntax-highlighting"
}

# Install tmux plugin manager
install_tpm() {
    clone_if_missing "$HOME/.tmux/plugins/tpm" \
        https://github.com/tmux-plugins/tpm "tmux plugin manager"
}

# Stow packages
stow_packages() {
    info "Stowing dotfiles..."

    # Real files/dirs at these paths would conflict with stow; back them up
    # out of the way (idempotently). We deliberately leave existing *symlinks*
    # alone here: `stow --restow` replaces those itself, and if stow later fails
    # on one package we must not have already deleted working symlinks for the
    # other packages (that stranded ~/.zshrc etc. in the past).
    # Note: $HOME/bin is intentionally NOT a backup target. It is a real dir
    # that stow merges symlinks *into* (no conflict); moving it aside would
    # also discard the ~/bin/dot symlink created by dot's own install.sh.
    local targets=(
        "$HOME/.zshrc"
        "$HOME/.phoenix.js"
        "$HOME/.config/tmux"
        "$HOME/.config/tmux-sessionizer"
        "$HOME/.config/ghostty"
        "$HOME/.config/kitty"
        "$HOME/.config/herdr/config.toml"
    )

    for target in "${targets[@]}"; do
        if [[ -e "$target" && ! -L "$target" ]]; then
            # Idempotent: drop a stale .backup first so mv never nests a dir
            # (mv into an existing dir) or silently overwrites a prior file backup.
            rm -rf "${target}.backup"
            warn "Backing up existing $target to ${target}.backup"
            mv "$target" "${target}.backup"
        fi
    done

    # Ensure required directories exist
    mkdir -p "$HOME/.config"
    mkdir -p "$HOME/bin"

    # Stow each package independently so a failure on one package doesn't
    # strand the others or abort the whole install under `set -e`. Real
    # failures are reported and surfaced via the return code.
    local failures=0
    for package in zsh phoenix tmux ghostty kitty herdr bin; do
        info "Stowing $package..."
        if ! stow -v --restow -d "$DOTFILES_DIR" -t "$HOME" "$package"; then
            warn "stow failed for package: $package"
            failures=$((failures + 1))
        fi
    done

    return "$failures"
}

# Install fonts
install_fonts() {
    info "Installing Oh My Posh fonts..."
    oh-my-posh font install Iosevka
}

# Setup secrets file
setup_secrets() {
    if [[ ! -f "$HOME/.zshrc.secrets" ]]; then
        if [[ -f "$DOTFILES_DIR/zsh/.zshrc.secrets" ]]; then
            info "Linking secrets file..."
            ln -sf "$DOTFILES_DIR/zsh/.zshrc.secrets" "$HOME/.zshrc.secrets"
        else
            warn "No secrets file found. Create zsh/.zshrc.secrets with your secrets."
        fi
    else
        info "Secrets file already exists"
    fi
}

# Main
main() {
    info "Starting dotfiles installation..."

    install_homebrew
    install_packages
    install_oh_my_zsh
    install_zsh_plugins
    install_tpm
    stow_packages
    install_fonts
    setup_secrets

    info "Installation complete!"
    info "Restart your terminal or run: source ~/.zshrc"
}

main "$@"