# ANDROID
# export ANDROID_HOME="$HOME/dev/android/sdk"
# export MANPATH="/usr/local/man:$MANPATH"
# export PATH="$PATH:$ANDROID_HOME/tools"
# export PATH="$PATH:$ANDROID_HOME/platform-tools"

# ANSIBLE
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"

# ASDF
export ASDF_CONFIG_FILE="$ASDF_DIR/asdfrc"
export ASDF_DATA_DIR="$XDG_DATA_HOME/asdf"

export ASDF_GEM_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME/gem/default-gems"
export ASDF_PYTHON_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME/pip/default-python-packages"
export ASDF_NPM_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME/npm/default-npm-packages"
export ASDF_YARN_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME/yarn/default-npm-packages"
. $(brew --prefix asdf)/libexec/asdf.sh # Completions
export ASDF_DIRENV_BIN="$(which direnv)" # From installation script
eval "$($ASDF_DIRENV_BIN hook zsh)" # From installation script

# DIRENV
eval "$(direnv hook zsh)"

# ELIXIR
export MIX_XDG=1 # https://hexdocs.pm/hex/Mix.Tasks.Hex.Config.html

# FLY
export FLY_CONFIG_DIR="$XDG_CONFIG_HOME/fly"

# FZF
# [ -f ${XDG_CONFIG_HOME}/fzf/fzf.zsh ] && source ${XDG_CONFIG_HOME}/fzf/fzf.zsh
source <(fzf --zsh)

# GOLANG
export GOPATH="$HOME/dev/go"
export GOROOT="$(brew --prefix golang)/libexec"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$(go env GOPATH)/bin"

# GNUSED
export PATH="$(brew --prefix gsed)/libexec/gnubin:$PATH"

# ITERM2
# iTerm2 Shell Integration & Utilities script
source $HOME/.config/iterm2/iterm2_shell_integration.zsh

# LAZYGIT
export LG_CONFIG_FILE="$XDG_CONFIG_HOME/lazygit/config.yml,$XDG_CONFIG_HOME/lazygit/themes/mocha/teal.yml"

# LESS
# Add syntax highlighting to less
export LESSOPEN="| bat --paging=never --color=always %s"

# MCFLY
eval "$(mcfly init zsh)"
export MCFLY_KEY_SCHEME=vim
export MCFLY_FUZZY=2
export MCFLY_RESULTS=20
export MCFLY_PROMPT=""

# POSTGRES
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"

# RUST
export CARGO_HOME="$HOME/dev/cargo"  # For cargo binaries, cache, and config
export RUSTUP_HOME="$HOME/dev/rustup"  # For XDG reasons, of course

# STARSHIP
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
eval "$(starship init zsh)"

# STOW
export STOW_DIR="$HOME/.dotfiles"

# THEFUCK
eval $(thefuck --alias)

# TMUX
export ZSH_TMUX_CONFIG="$XDG_CONFIG_HOME/tmux/tmux.conf"  # For the zplug plugin

# ZOXIDE
eval "$(zoxide init zsh)"

