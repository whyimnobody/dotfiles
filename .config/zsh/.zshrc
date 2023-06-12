# Path to your oh-my-zsh installation.
export ZSH="$HOME/.config/oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"
# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"
# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# HIST_STAMPS="mm/dd/yyyy"
HISTFILE="$XDG_STATE_HOME/zsh/history"
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS

# You may need to manually set your language environment
export LANG=en_GB.UTF-8

# Path Management
# Add local/bin to PATH
export PATH="/usr/local/bin:$PATH"

# 1Password SSH Agent
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

# src: https://koenwoortman.com/zsh-split-zshrc-into-multiple-files/
# Load seperated config files
for conf in "$XDG_CONFIG_HOME/zsh/config.d/"*.zsh; do
  source "${conf}"
done

unset conf
