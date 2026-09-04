# GENERAL
# ------------------------------------------------------------------------------
export LC_ALL="en_ZA.UTF-8"

export XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

case "$(uname -s)" in
  Darwin)
    _runtime_root="${TMPDIR:-$(getconf DARWIN_USER_TEMP_DIR)}"
    export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-${_runtime_root%/}/xdg-runtime}"
    mkdir -p "${XDG_RUNTIME_DIR}"
    chmod 700 "${XDG_RUNTIME_DIR}"
    unset _runtime_root
  ;;
  Linux)
    mkdir -p "${XDG_BIN_HOME}"
  ;;
esac

export GIT_REPOS="$HOME/repos"

# PACKAGES
# ------------------------------------------------------------------------------
export PACKAGES_DATABASE="$XDG_STATE_HOME/dotfiles/dotfiles.db"
export NIX_CONF_DIR="$XDG_CONFIG_HOME/nix"

# ZSH SPECIFIC
# ------------------------------------------------------------------------------
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
