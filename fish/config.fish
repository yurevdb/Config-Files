### GLOBAL VARIABLES
#

set -x PATH $PATH /usr/local/go/bin
set -x EDITOR nvim
set -x VISUAL nvim

# Load private config
# (local settings or computer specific config for example)
if [ -f $HOME/.config/fish/private.fish ]
    source $HOME/.config/fish/private.fish
end

# Colors for ls command
set -gx LSCOLORS "Cxbgdxdxbxdgeghegeacad"

# Keys binding
bind "^X\\x7f" backward-kill-line

# Editor
set -x EDITOR vim
set -x GIT_EDITOR $EDITOR
set -x SUDO_EDITOR "rvim -u NONE"

switch (uname)
case Linux
    set -x OSTYPE "Linux"
case Darwin
    set -x OSTYPE "MacOS"
case FreeBSD NetBSD DragonFly
    set -x OSTYPE "FreeBSD"
case '*'
    set -x OSTYPE "unknown"
end

## ENV

# Fish 3.1+ doesn't add binaries to the path autmatically anymore
# https://github.com/fish-shell/fish-shell/issues/6594
contains /usr/local/bin $PATH
or set PATH /usr/local/bin $PATH
# On M1 Macs, homebrew installs things in /opt/homebrew
contains /opt/homebrew/bin
or set PATH /opt/homebrew/bin $PATH

# rustup shell setup
if not contains "$HOME/.cargo/bin" $PATH
    # Prepending path in case a system-installed rustc needs to be overridden
    set -x PATH "$HOME/.cargo/bin" $PATH
end

#
### ALIAS

alias vim="nvim"

#
### PROMPT
#

# Prevent directories names from being shortened
set fish_prompt_pwd_dir_length 0
# fish_prompt defined in ~/.config/fish/functions/fish_prompt.fish
source ~/.config/fish/prompt.fish
