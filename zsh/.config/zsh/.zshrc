# zsh config
# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"
# ENABLE_CORRECTION="true"

# HIST_STAMPS="mm/dd/yyyy"
HISTFILE="$XDG_STATE_HOME/zsh/history"
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt autocd
setopt always_to_end

# Path Management
# Add local/bin to PATH
export PATH=/usr/local/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/sbin:$PATH
# Add XDG_BIN_HOME to PATH
export PATH=$PATH:$XDG_BIN_HOME

# You may need to manually set your language environment
export LANG=en_GB.UTF-8


# Plugin Manager
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"
zinit ice atload'unalias zi'

# Plugins
zinit ice wait"1" lucid # load after 1 second
zinit light zsh-users/zsh-autosuggestions
zinit ice wait"1" lucid # load after 1 second
zinit light zsh-users/zsh-completions
zinit ice wait"1" lucid # load after 1 second
zinit light zsh-users/zsh-history-substring-search
zinit ice wait"1" lucid # load after 1 second
zinit light zsh-users/zsh-syntax-highlighting
# zinit ice wait"1" lucid # load after 1 second
zinit light Aloxaf/fzf-tab
# TODO: Check out to see if worthwhile
# https://github.com/Freed-Wu/fzf-tab-source

# zinit light djui/alias-tips
zinit ice wait"1" lucid # load after 1 second
zinit light g-plane/zsh-yarn-autocompletions

zinit ice wait"1" lucid # load after 1 second
zinit snippet OMZP::colored-man-pages
zinit ice wait"1" lucid # load after 1 second
zinit snippet OMZP::gitignore
zinit ice wait"1" lucid # load after 1 second
zinit snippet OMZP::golang
zinit ice wait"1" lucid # load after 1 second
zinit snippet OMZP::npm

# Completion config
autoload -U compinit && compinit
zinit cdreplay -q

source "${XDG_CONFIG_HOME}/zsh/vars/zstyle.zsh"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'lsd $realpath'
# https://unix.stackexchange.com/questions/97843/how-can-i-search-history-with-text-already-entered-at-the-prompt-in-zsh
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# Keymaps
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

export EDITOR="$(which nvim)"

# src: https://koenwoortman.com/zsh-split-zshrc-into-multiple-files/
source "$XDG_CONFIG_HOME/zsh/scripts/applications.zsh"
source "$XDG_CONFIG_HOME/zsh/scripts/functions.zsh"
source "$XDG_CONFIG_HOME/zsh/scripts/aliases.zsh"
source "$XDG_CONFIG_HOME/zsh/scripts/hooks.zsh"
