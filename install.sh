#!/bin/bash

# zsh
ln -sf "$HOME/dotfiles/zsh/.zshenv" "$HOME"
source "$HOME/.zshenv"
mkdir -p "$XDG_CONFIG_HOME/zsh"
ln -sf "$DOTFILES/zsh/.zshenv" "$HOME"
ln -sf "$DOTFILES/zsh/.zshrc" "$XDG_CONFIG_HOME/zsh"
ln -sf "$DOTFILES/zsh/aliases" "$XDG_CONFIG_HOME/zsh/aliases"
rm -rf "$XDG_CONFIG_HOME/zsh/external"
ln -sf "$DOTFILES/zsh/external" "$XDG_CONFIG_HOME/zsh"

# NeoVim
mkdir -p "$XDG_CONFIG_HOME/nvim"
mkdir -p "$XDG_CONFIG_HOME/nvim/undo"
ln -sf "$DOTFILES/nvim/init.lua" "$XDG_CONFIG_HOME/nvim"
ln -s "$DOTFILES/nvim/lua" "$XDG_CONFIG_HOME/nvim"

# radian
mkdir -p "$XDG_CONFIG_HOME/radian"
ln -sf "$DOTFILES/radian/profile" "$XDG_CONFIG_HOME/radian"

# tmux
mkdir -p "$XDG_CONFIG_HOME/tmux"
ln -sf "$DOTFILES/tmux/tmux.conf" "$XDG_CONFIG_HOME/tmux"

[ ! -d "$XDG_CONFIG_HOME/tmux/plugins" ] \
  && git clone https://github.com/tmux-plugins/tpm \
  "$XDG_CONFIG_HOME/tmux/plugins/tpm"
