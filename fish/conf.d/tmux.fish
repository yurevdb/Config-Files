if not set -q TMUX
    set -g TMUX TERM=xterm-256color tmux new-session -d -s base
    eval $TMUX
    tmux attach-session -d -t base
end
