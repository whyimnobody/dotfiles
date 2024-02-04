export EDITOR="NVIM_APPNAME='lazyvim' $(which nvim)"

# Path to your oh-my-zsh installation.
export OMZ="$XDG_CONFIG_HOME/oh-my-zsh"

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
setopt HIST_IGNORE_SPACE

# Path Management
# Add local/bin to PATH
export PATH=/usr/local/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/sbin:$PATH

# You may need to manually set your language environment
export LANG=en_GB.UTF-8

# OHMYZSH Sourcing before custom configs
source $OMZ/oh-my-zsh.sh

# src: https://koenwoortman.com/zsh-split-zshrc-into-multiple-files/
# Load seperated config files
for conf in "$XDG_CONFIG_HOME/zsh/config.d/"*.zsh; do
  source "${conf}"
done
unset conf
