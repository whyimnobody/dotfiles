# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# ALIASES
# ------------------------------------------------------------------------------
alias resource="refresh"

alias dotfiles="lvim $HOME/.dotfiles"
alias lazyvim="lvim $XDG_CONFIG_HOME/lazyvim"
alias zshconfig="lvim $XDG_CONFIG_HOME/zsh"

alias pwdc="pwd | pbcopy"
alias clean.node="rm -rf node_modules/ package-lock.json yarn-lock.json"
alias whatsmyip="dig TXT +short o-o.myaddr.l.google.com @ns1.google.com"

alias random.pwd="shuf -n4 /usr/share/dict/words | tr '\n' _ | sed 's/.$/\n/' | pbcopy"
alias random.key="openssl rand -base64 32 | tr -d '\n' | pbcopy"

# QoL Aliases
alias notes="lvim $HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/whyimnobody/"
alias lvim="NVIM_APPNAME='lazyvim' nvim"
# TODO: Update to accept arg for app name
alias ll="lsd -l"
alias tree="lsd --tree"
alias upgrade="zplug update && brew update && brew upgrade && brew cleanup && omz update"

# System-related aliases
alias damagecheck.off="sudo spctl --master-disable"
alias damagecheck.on="sudo spctl --master-enable"

