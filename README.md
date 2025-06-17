# dotfiles


### Install things

```
brew install neovim

brew install --cask phoenix

brew install tmux

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

```

Note: Neovim config is currently done via a fork of `kickstart.nvim`. This is stored in a forked github repo instead of this dotfiles package. Run the folowing to pull it into the config:

```
git clone https://github.com/ronsanzone/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

### Symlink the config

This assumes that our dotfiles package is in `~/code/dotfiles/`

```
ln -s ~/code/dotfiles/phoenix/.phoenix.js ~/.phoenix.js

ln -s ~/code/dotfiles/tmux/tmux.conf ~/.config/tmux/tmux.conf
```
