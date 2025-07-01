# dotfiles


## Install things

```
brew install neovim

brew install --cask kitty

brew install --cask phoenix

brew install tmux

brew install fzf

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/c
ustom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-
my-zsh/custom}/plugins/zsh-syntax-highlighting

brew install jandedobbeleer/oh-my-posh/oh-my-posh

oh-my-posh font install

Install font “Iosevka”
```

## NeoVim
[!Note] Neovim config is currently done via a fork of `kickstart.nvim`. This is stored in a forked github repo instead of this dotfiles package. Run the folowing to pull it into the config:

```
git clone https://github.com/ronsanzone/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

## Symlink the config

This assumes that our dotfiles package is in `~/code/dotfiles/`

```
ln -s ~/code/dotfiles/zsh/.zshrc ~/.zshrc

ln -s ~/code/dotfiles/phoenix/.phoenix.js ~/.phoenix.js

mkdir ~/.config/tmux
ln -s ~/code/dotfiles/tmux/tmux.conf ~/.config/tmux/tmux.conf
ln -s ~/code/dotfiles/tmux/tmux-sessionizer.conf ~/.config/tmux-sessionizer/tmux-sessionizer.conf

mkdir ~/.config/kitty
ln -s ~/code/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf

```

## Install Random Tools

```
brew install --cask font-monaspace-nerd-font font-noto-sans-symbols-2
brew install bash bc coreutils gawk gh glab gsed jq nowplaying-cli
brew install tree
brew install btop atop
brew install goenv
brew install mongosh
brew install zk
brew install ripgrep
```
