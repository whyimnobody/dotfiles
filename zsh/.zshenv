# GENERAL
# ------------------------------------------------------------------------------
export XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

export GIT_REPOS="$HOME/repos"

# PACKAGES
# ------------------------------------------------------------------------------
export PACKAGES_DATABASE="$XDG_STATE_HOME/dotfiles/dotfiles.db"
export NIX_CONF_DIR="$XDG_CONFIG_HOME/nix"

# ZSH SPECIFIC
# ------------------------------------------------------------------------------
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
