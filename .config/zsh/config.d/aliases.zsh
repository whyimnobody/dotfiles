# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# ALIASES
# ------------------------------------------------------------------------------
alias zshconfig="lvim $XDG_CONFIG_HOME/zsh"
alias resource="refresh"

alias dotfiles="lvim $GIT_REPOS/dotfiles"
alias lazyvim="lvim $XDG_CONFIG_HOME/lazyvim"

alias pwdc="pwd | pbcopy"
alias clean.node="rm -rf node_modules/ package-lock.json yarn-lock.json"
alias whatsmyip="dig TXT +short o-o.myaddr.l.google.com @ns1.google.com"

alias rndpwd="shuf -n4 /usr/share/dict/words | tr '\n' _ | sed 's/.$/\n/'"
alias rndpwdc="shuf -n4 /usr/share/dict/words | tr '\n' _ | sed 's/.$/\n/' | pbcopy"

# QoL Aliases
alias lvim="NVIM_APPNAME='lazyvim' nvim"
# TODO: Update to accept arg for app name
alias ll="lsd -l"
alias tree="lsd --tree"
alias upgrade="zplug update && brew update && brew upgrade && brew cleanup && omz update"

alias bkup.kitty="rsync -av --delete --progress $XDG_CONFIG_HOME/kitty $XDG_CONFIG_HOME/dotfiles/.config/"
alias bkup.lvim="rsync -av --delete --progress $XDG_CONFIG_HOME/lazyvim $XDG_CONFIG_HOME/dotfiles/.config/"
alias bkup.nvim="rsync -av --delete --progress $XDG_CONFIG_HOME/nvim $XDG_CONFIG_HOME/dotfiles/.config/"
alias bkup.starship="rsync -av --delete --progress $XDG_CONFIG_HOME/starship $XDG_CONFIG_HOME/dotfiles/.config/"
alias bkup.tmux="rsync -av --delete --progress $XDG_CONFIG_HOME/tmux $XDG_CONFIG_HOME/dotfiles/.config/"
alias bkup.zsh="rsync -av --delete --progress $XDG_CONFIG_HOME/zsh $XDG_CONFIG_HOME/dotfiles/.config/"
alias bkup="rsync -av --delete --progress $XDG_CONFIG_HOME $XDG_CONFIG_HOME/dotfiles/"

# System-related aliases
alias damagecheck.off="sudo spctl --master-disable"
alias damagecheck.on="sudo spctl --master-enable"

