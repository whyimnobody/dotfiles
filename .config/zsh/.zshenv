# GENERAL
# ------------------------------------------------------------------------------
# TODO: Unexport these once content with setup
export XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# ZSH SPECIFIC
# ------------------------------------------------------------------------------
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
