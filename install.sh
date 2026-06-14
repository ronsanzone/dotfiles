#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

info() { echo "[INFO] $*"; }
warn() { echo "[WARN] $*"; }
error() { echo "[ERROR] $*" >&2; exit 1; }

# Install Homebrew if not present
install_homebrew() {
    if ! command -v brew &>/dev/null; then
        info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        info "Homebrew already installed"
    fi
}

# Install packages from Brewfile
install_packages() {
    info "Installing packages from Brewfile..."
    brew bundle install --file="$DOTFILES_DIR/Brewfile"
}

# Install Oh My Zsh if not present
install_oh_my_zsh() {
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        info "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        info "Oh My Zsh already installed"
    fi
}

# Install zsh plugins
install_zsh_plugins() {
    local zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

    if [[ ! -d "$zsh_custom/plugins/zsh-autosuggestions" ]]; then
        info "Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions "$zsh_custom/plugins/zsh-autosuggestions"
    else
        info "zsh-autosuggestions already installed"
    fi

    if [[ ! -d "$zsh_custom/plugins/zsh-syntax-highlighting" ]]; then
        info "Installing zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$zsh_custom/plugins/zsh-syntax-highlighting"
    else
        info "zsh-syntax-highlighting already installed"
    fi
}

# Install tmux plugin manager
install_tpm() {
    if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
        info "Installing tmux plugin manager..."
        git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    else
        info "TPM already installed"
    fi
}

# Install neovim config
install_neovim_config() {
    local nvim_dir="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
    if [[ ! -d "$nvim_dir" ]]; then
        info "Installing neovim config..."
        git clone https://github.com/ronsanzone/kickstart.nvim.git "$nvim_dir"
    else
        info "Neovim config already installed"
    fi
}

# Stow packages
stow_packages() {
    info "Stowing dotfiles..."

    # Remove existing files/symlinks that would conflict
    local targets=(
        "$HOME/.zshrc"
        "$HOME/.phoenix.js"
        "$HOME/.config/tmux"
        "$HOME/.config/tmux-sessionizer"
        "$HOME/.config/ghostty"
        "$HOME/.config/kitty"
        "$HOME/bin"
    )

    for target in "${targets[@]}"; do
        if [[ -e "$target" && ! -L "$target" ]]; then
            warn "Backing up existing $target to ${target}.backup"
            mv "$target" "${target}.backup"
        elif [[ -L "$target" ]]; then
            rm "$target"
        fi
    done

    # Ensure required directories exist
    mkdir -p "$HOME/.config"
    mkdir -p "$HOME/bin"

    # Stow each package explicitly into $HOME
    for package in zsh phoenix tmux ghostty kitty bin; do
        info "Stowing $package..."
        stow -v --restow \
            -d "$DOTFILES_DIR" \
            -t "$HOME" \
            "$package"
    done
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
    install_neovim_config
    stow_packages
    install_fonts
    setup_secrets

    info "Installation complete!"
    info "Restart your terminal or run: source ~/.zshrc"
}

main "$@"

