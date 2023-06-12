# ANDROID
# ------------------------------------------------------------------------------
# export ANDROID_HOME="$HOME/dev/android/sdk"
# export PATH="$PATH:$ANDROID_HOME/tools"
# export PATH="$PATH:$ANDROID_HOME/platform-tools"
# export MANPATH="/usr/local/man:$MANPATH"

# ASDF
# ------------------------------------------------------------------------------
export ASDF_CONFIG_FILE="$ASDF_DIR/asdfrc"
export ASDF_DATA_DIR="$XDG_DATA_HOME/asdf"

export ASDF_GEM_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME/gem/default-gems"
export ASDF_PYTHON_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME/pip/default-python-packages"
export ASDF_NPM_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME/npm/default-npm-packages"
export ASDF_YARN_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME/yarn/default-npm-packages"
. $(brew --prefix asdf)/libexec/asdf.sh # Completions
export ASDF_DIRENV_BIN="$(which direnv)"  # From installation script
eval "$($ASDF_DIRENV_BIN hook zsh)"  # From installation script

# DIRENV
# ------------------------------------------------------------------------------
eval "$(direnv hook zsh)"

# FZF
# ------------------------------------------------------------------------------
[ -f ${XDG_CONFIG_HOME}/fzf/fzf.zsh ] && source ${XDG_CONFIG_HOME}/fzf/fzf.zsh

# GOLANG
# ------------------------------------------------------------------------------
# specify golang envvars
export GOPATH="$HOME/dev/go"
export GOROOT="$(brew --prefix golang)/libexec"
export GOBIN="$GOPATH/bin"
# export PATH="$PATH:$GOROOT/bin"

# ITERM2
# ------------------------------------------------------------------------------
# iTerm2 Shell Integration & Utilities script
source $HOME/.config/iterm2/iterm2_shell_integration.zsh

# MCFLY
# ------------------------------------------------------------------------------
eval "$(mcfly init zsh)"
export MCFLY_KEY_SCHEME=vim
export MCFLY_FUZZY=2
export MCFLY_RESULTS=20
export MCFLY_PROMPT=""

# POSTGRES
# ------------------------------------------------------------------------------
# Add Postgres to the Path
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"

# RUST
# ------------------------------------------------------------------------------
export CARGO_HOME="$HOME/dev/cargo"  # For cargo binaries
# export PATH="$PATH:$XDG_BIN_HOME/bin"  # For cargo binaries

# OHMYZSH + STARSHIP
# ------------------------------------------------------------------------------
source $ZSH/oh-my-zsh.sh
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
eval "$(starship init zsh)"

# THEFUCK
# ------------------------------------------------------------------------------
eval $(thefuck --alias)

# TMUX
# ------------------------------------------------------------------------------
export ZSH_TMUX_CONFIG="$XDG_CONFIG_HOME/tmux/tmux.conf"  # For the zplug plugin

# ZOXIDE
# ------------------------------------------------------------------------------
eval "$(zoxide init zsh)"

