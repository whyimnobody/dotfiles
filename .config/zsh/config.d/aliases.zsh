# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# ALIASES
# ------------------------------------------------------------------------------
alias zshconfig="nvim $XDG_CONFIG_HOME/zsh/.zshrc"
alias refresh="source $XDG_CONFIG_HOME/zsh/.zshrc"
alias resource="source $XDG_CONFIG_HOME/zsh/.zshrc"
alias zshupdate=""

alias venvconfig="nvim $VIRTUAL_ENV/bin/postactivate"
alias venvunconfig="nvim $VIRTUAL_ENV/bin/postdeactivate"
alias venvsource="source $VIRTUAL_ENV/bin/postactivate"

alias pwdc="pwd | pbcopy"
alias clean-node="rm -rf node_modules/ package-lock.json yarn-lock.json"
alias whatsmyip="dig TXT +short o-o.myaddr.l.google.com @ns1.google.com"

alias rndpwd="shuf -n4 /usr/share/dict/words | tr '\n' _ | sed 's/.$/\n/'"
alias rndpwdc="shuf -n4 /usr/share/dict/words | tr '\n' _ | sed 's/.$/\n/' | pbcopy"

alias lvim="NVIM_APPNAME='lazyvim' nvim"

# QoL Aliases
# TODO: Update to accept arg for app name
alias bootstrap:psql="f() { curl -o docker-compose.yml https://gitlab.com/-/snippets/2353106/raw/main/docker-compose.yml && sed -i 's/'$1'/something_creative/' docker-compose.yml };f"
alias ll="exa -lg --icons"
alias tree="exa --tree --icons"

alias bkup:nvim="rsync -av --delete --progress $XDG_CONFIG_HOME/nvim $XDG_CONFIG_HOME/dotfiles/.config/"
alias bkup:kitty="rsync -av --delete --progress $XDG_CONFIG_HOME/kitty $XDG_CONFIG_HOME/dotfiles/.config/"
alias bkup:starship="rsync -av --delete --progress $XDG_CONFIG_HOME/starship/starship.toml $XDG_CONFIG_HOME/dotfiles/.config/"
alias bkup:zsh="rsync -av --exclude .zsh_history --exclude '.zcomp*' --delete --progress $XDG_CONFIG_HOME/zsh $XDG_CONFIG_HOME/dotfiles/.config/"

alias sync:dotfiles="rsync -auv --progress $XDG_CONFIG_HOME/dotfiles/.config/ $XDG_CONFIG_HOME/.config/"

# System-related aliases
alias damagecheck:off="sudo spctl --master-disable"
alias damagecheck:on="sudo spctl --master-enable"
