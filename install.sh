#!/bin/bash

# Check if the ~/.config directory exists
if [ ! -d "~/.config" ]; then
  mkdir ~/.config
fi

# i3 configs
if [ ! -d "~/.config/i3" ]; then
  mkdir ~/.config/i3
fi
cp -l ./i3/config ~/.config/i3/config
if [ ! -d "~/.config/i3status" ]; then
  mkdir ~/.config/i3status
fi
cp -l ./i3status/config ~/.config/i3status/config

# Tmux
cp -l ./tmux/.tmux.conf ~/.tmux.conf

# Neovim
if [ ! -d "~/.config/nvim" ]; then
  mkdir ~/.config/nvim
fi
cp -l ./nvim/init.lua ~/.config/nvim/init.lua

# Ghostty
if [ ! -d "~/.config/ghostty/" ]; then
  mkdir ~/.config/ghostty/
fi
cp -l ./ghostty/config ~/.config/ghostty/config
cp -l ./ghostty/startup.sh ~/.config/ghostty/startup.sh
chmod +x ~/.config/ghostty/startup.sh

# Fish
if [ ! -d "~/.config/fish/" ]; then
  mkdir ~/.config/fish/
fi
cp -l ./fish/config.fish ~/.config/fish/config.fish
cp -l ./fish/fish_prompt.fish ~/.config/fish/fish_prompt.fish
cp -l ./fish/fish_variables ~/.config/fish/fish_variables
