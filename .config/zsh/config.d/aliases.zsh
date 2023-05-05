# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# ALIASES
# ------------------------------------------------------------------------------
alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
alias refresh="source ~/.zshrc"

alias envconfig="code $VIRTUAL_ENV/bin/postactivate"
alias envunconfig="code $VIRTUAL_ENV/bin/postdeactivate"
alias envsource="source $VIRTUAL_ENV/bin/postactivate"

alias pwdc="pwd | pbcopy"
alias clean-node="rm -rf node_modules/ package-lock.json"
alias whatsmyip="dig TXT +short o-o.myaddr.l.google.com @ns1.google.com"

alias rndpwd="shuf -n10 /usr/share/dict/words | tr '\n' _ | sed 's/.$/\n/'"
alias rndpwdc="shuf -n10 /usr/share/dict/words | tr '\n' _ | sed 's/.$/\n/' | pbcopy"

# PyPy aliases
alias pypenv="pipenv --python /usr/local/homebrew/bin/pypy3"

# QoL Aliases
alias bootstrap:psql="f() { curl -o docker-compose.yml https://gitlab.com/-/snippets/2353106/raw/main/docker-compose.yml && sed -i 's/'$1'/something_creative/' docker-compose.yml };f"

# System-related aliases
alias damagecheck:off="sudo spctl --master-disable"
alias damagecheck:on="sudo spctl --master-enable"
# Intel-apps homebrew
# alias intelbrew="arch -x86_64 /usr/local/homebrew/bin/brew"
