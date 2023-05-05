# ANDROID
# ------------------------------------------------------------------------------
# export ANDROID_HOME="$HOME/dev/android/sdk"
# export PATH="$PATH:$ANDROID_HOME/tools"
# export PATH="$PATH:$ANDROID_HOME/platform-tools"
# export MANPATH="/usr/local/man:$MANPATH"

# DIRENV
# ------------------------------------------------------------------------------
eval "$(direnv hook zsh)"

# FZF
# ------------------------------------------------------------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# GOLANG
# ------------------------------------------------------------------------------
# # Add golang envvars
export GOPATH="$HOME/dev/go"
export GOROOT="$(brew --prefix golang)/libexec"
export GOBIN="$GOPATH/bin"
# export PATH="$PATH:$GOROOT/bin"

# ITERM2
# ------------------------------------------------------------------------------
# iTerm2 Shell Integration & Utilities script
source $HOME/.config/iterm2/iterm2_shell_integration.zsh

# POSTGRES
# ------------------------------------------------------------------------------
# Add Postgres to the Path
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"

# POETRY
# ------------------------------------------------------------------------------
# Setup poetry
# export PATH="$PATH:$HOME/Library/Python/3.9/bin"

# RUBY & RBENV
# ------------------------------------------------------------------------------
# export PATH="$HOME/.rbenv/shims:$PATH"
# eval "$(rbenv init - zsh)"

# RUST
# ------------------------------------------------------------------------------
export PATH="$PATH:$HOME/.cargo/bin"  # For carg binaries

# THEFUCK
# ------------------------------------------------------------------------------
eval $(thefuck --alias)

# OHYMYZSH
# ------------------------------------------------------------------------------
source $ZSH/oh-my-zsh.sh
