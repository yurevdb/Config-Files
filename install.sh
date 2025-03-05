#!/bin/bash

echo "This will remove the directories for the configs of i3, i3status, tmux, ghostty and fish."
echo "Backup your existsing configs in a different place to be safe."
read -p "Do you want to continue? [y/n]: " yn
if [ $yn = [Nn]* ]; then
  exit 1
fi

user="$(whoami)"

# Check if the ~/.config directory exists
config="/home/${user}/.config/"
if [ ! -d "${config}" ]; then
  mkdir ${config}
fi

# i3 configs
i3config="/home/${user}/.config/i3/"
if [ -d "${i3config}" ]; then
  rm -rf ${i3config}
  mkdir ${i3config}
  cp -l ./i3/config ~/.config/i3/config
fi
i3statuconfigs="/home/${user}/.config/i3status/"
if [ -d "${i3statusconfig}" ]; then
  rm -rf ${i3statusconfig}
  mkdir ${i3statusconfig}
  cp -l ./i3status/config ~/.config/i3status/config
fi

# Tmux
rm "/home/${user}/.tmux.conf"
cp -l ./tmux/.tmux.conf "/home/${user}/.tmux.conf"

# Neovim
nvimconfig="/home/${user}/.config/nvim/"
if [ -d "${nvimconfig}" ]; then
  rm -rf ${nvimconfig}
  mkdir ${nvimconfig}
  cp -l ./nvim/init.lua ~/.config/nvim/init.lua
fi

# Ghostty
ghosttyconfig="/home/${user}/.config/ghostty/"
if [ -d "${ghosttyconfig}" ]; then
  rm -rf ${ghosttyconfig}
  mkdir ${ghosttyconfig}
  cp -l ./ghostty/config ~/.config/ghostty/config
  cp -l ./ghostty/startup.sh ~/.config/ghostty/startup.sh
  chmod +x ~/.config/ghostty/startup.sh
fi

# Fish
fishconfig="/home/${user}/.config/fish/"
if [ -d "${fishconfig}" ]; then
  rm -rf ${fishconfig}
  mkdir ${fishconfig}
  cp -l ./fish/config.fish ~/.config/fish/config.fish
  cp -l ./fish/fish_prompt.fish ~/.config/fish/fish_prompt.fish
  cp -l ./fish/fish_variables ~/.config/fish/fish_variables
fi
