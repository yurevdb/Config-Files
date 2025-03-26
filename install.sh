#!/bin/bash

echo "This install script will override the config files for i3, tmux, neovim, alacritty, fish and dunst."
echo "Backup your existsing configs in a different place to be safe."
read -p "Do you want to continue? [y/n]: " yn
if [ $yn = [Nn]* ]; then
  exit 1
fi

user="$(whoami)"

#############################################
### INSTALL PACKAGES
#############################################

# Install script
#
# i3
# tmux
# neovim
# ghostty
# fish
# dunst
#
# opera
# apple music
# steam
# solaar: logitech mouse
# thunar
# htop
# neofech
# 
# go
# gopls
# clang
# clangd
# zig
# zls
# rust
# rust-analyzer

#############################################
### CONFIG FILES 
#############################################

# Check if the ~/.config directory exists
config="/home/${user}/.config/"
if [ ! -d "${config}" ]; then
  mkdir ${config}
fi

# set wallpaper
# install feh
# TODO: check user display resolution??
wallpaper="${config}/wallpaper_4k.png"
cp -f ./wallpaper_4k.png ${wallpaper}
feh --bg-fill ${wallpaper}

# i3 configs
i3config="${config}/i3/"
if [ ! -d "${i3config}" ]; then
  mkdir ${i3config}
fi
cp -lf ./i3/config ~/.config/i3/config

i3statusconfig="${config}/i3status/"
if [ ! -d "${i3statusconfig}" ]; then
  mkdir ${i3statusconfig}
fi
cp -lf ./i3status/config ~/.config/i3status/config

# Tmux
rm "/home/${user}/.tmux.conf"
cp -lf ./tmux/.tmux.conf "/home/${user}/.tmux.conf"

# Neovim
nvimconfig="${config}/nvim/"
if [ ! -d "${nvimconfig}" ]; then
  mkdir ${nvimconfig}
fi
cp -lf ./nvim/init.lua ~/.config/nvim/init.lua

# Ghostty
# ghosttyconfig="/${config}/ghostty/"
# if [ ! -d "${ghosttyconfig}" ]; then
#   mkdir ${ghosttyconfig}
# fi
# cp -lf ./ghostty/config ~/.config/ghostty/config
# cp -lf ./ghostty/startup.sh ~/.config/ghostty/startup.sh
# chmod +x ~/.config/ghostty/startup.sh

# Fish
fishconfig="/${config}/fish/"
if [ ! -d "${fishconfig}" ]; then
  mkdir ${fishconfig}
fi
cp -lf ./fish/config.fish ~/.config/fish/config.fish
cp -lf ./fish/prompt.fish ~/.config/fish/prompt.fish
cp -lf ./fish/fish_variables ~/.config/fish/fish_variables

# Dunst
dunstconfig="/${config}/dunst/"
if [ ! -d "${dunstconfig}" ]; then
  mkdir ${dunstconfig}
fi
cp -lf ./dunst/dunstrc ~/.config/dunst/dunstrc

# Alacritty
alacrittyconfig="/${config}/alacritty/"
if [ ! -d "${alacrittyconfig}" ]; then
  mkdir ${alacrittyconfig}
fi
cp -lf ./alacritty/alacritty.toml ${alacrittyconfig}alacritty.toml
