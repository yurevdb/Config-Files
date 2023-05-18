alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias ls="ls -FG"
alias rm="rm -i"
alias ssh_tunnel_bg="ssh -f -N"
alias sha256sum="shasum -a 256"
alias who8080="lsof -i tcp:8080"
alias getPID="ps -p"
alias unset="set --erase"
alias pya="pyenv activate"
alias pyd="pyenv deactivate"
alias getSize="stat -f%z"
alias cleanAllNodeModules="find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +"
alias be="bundle exec"
alias bi="bundle install"
alias vim="nvim"

if type -q exa
    alias ls "exa -l -g --icons"
    alias la "ll -a"
end
