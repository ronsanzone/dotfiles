# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quick Start

```bash
git clone https://github.com/ronsanzone/dotfiles.git ~/code/dotfiles
cd ~/code/dotfiles
./install.sh
```

The install script will:
- Install Homebrew (if needed)
- Install all packages from the Brewfile
- Install Oh My Zsh and plugins
- Install tmux plugin manager
- Clone neovim config
- Stow all dotfile packages
- Install fonts

## Required Manual Steps
The following commands are needed to set the Kitty and Tmux themes:
```bash
kitten themes Kanagawa

<tmux leader> + I
```

## Manual Usage

After initial setup, manage individual packages with stow:

```bash
# Apply a package
stow zsh

# Remove a package
stow -D zsh

# Re-apply (useful after changes)
stow -R zsh
```

## Structure

Each directory is a stow package that mirrors the target path from `$HOME`:

```
dotfiles/
├── bin/bin/*                                   → ~/bin/*
├── ghostty/.config/ghostty/config              → ~/.config/ghostty/config
├── herdr/.config/herdr/config.toml             → ~/.config/herdr/config.toml
├── kitty/.config/kitty/kitty.conf              → ~/.config/kitty/kitty.conf
├── phoenix/.phoenix.js                         → ~/.phoenix.js
├── tmux/.config/tmux/tmux.conf                 → ~/.config/tmux/tmux.conf
├── tmux/.config/tmux-sessionizer/...           → ~/.config/tmux-sessionizer/...
└── zsh/.zshrc                                  → ~/.zshrc
```

## Secrets

Secrets are stored in `zsh/.zshrc.secrets` (gitignored) and sourced by `.zshrc`.

To set up secrets on a new machine, create `~/.zshrc.secrets`:

```bash
# Example contents
export API_KEY=your-secret-key
```

## Neovim

Neovim config is maintained in a separate repo:
https://github.com/ronsanzone/kickstart.nvim

The install script clones it automatically to `~/.config/nvim`.

## LaunchAgent
We have some launch agent scripts that can be installed to manage processes running on the laptop:

### OpenCode Server
This starts up an opencode server on localhost to be used by various agentic coding tools:
```
# Copy the plist into place
cp ./launchagents/com.user.opencode.plist ~/Library/LaunchAgents/

# Load and start the service
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.user.opencode.plist

# Verify it's running
launchctl print gui/$(id -u)/com.user.opencode
```
## Packages Installed

See [Brewfile](./Brewfile) for the full list. Highlights:
- neovim, tmux, fzf, ripgrep
- kitty, phoenix
- oh-my-posh, zsh plugins
- Development tools (gh, glab, goenv, mongosh)
