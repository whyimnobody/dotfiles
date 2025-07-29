# ALIASES
# ------------------------------------------------------------------------------
alias resource="refresh"

alias lazyvim="nvim $XDG_CONFIG_HOME/nvim"
alias zshconfig="nvim $XDG_CONFIG_HOME/zsh"
alias sshconfig="nvim $HOME/.ssh/config"

alias pwdc="pwd | pbcopy"
alias clean.node="rm -rf node_modules/ package-lock.json yarn-lock.json"
alias whatsmyip="dig TXT +short o-o.myaddr.l.google.com @ns1.google.com"

# TODO: Make OS agnostic
alias random.phrase="shuf -n4 /usr/share/dict/words | tr '\n' _ | sed 's/.$/\n/' | pbcopy"
alias random.pwd="openssl rand -hex 64 | tr -d '\n' | pbcopy"
# QoL Aliases
# TODO: Make OS agnostic
alias notes="nvim $HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/whyimnobody/"
alias vim="nvim"
alias art="php artisan"
# TODO: Update to accept arg for app name
# from oh-my-zsh
alias md='mkdir -p'
alias rd='rmdir'
alias ~='cd ~'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
# directory stuff
alias ls="lsd"
alias ll="lsd -l"
alias tree="lsd --tree"
# System-related aliases

case "$(uname -s)" in
  Darwin)
    alias damagecheck.off="sudo spctl --master-disable"
    alias damagecheck.on="sudo spctl --master-enable"
  ;;
esac

