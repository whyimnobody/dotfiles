# PLUGINS
# ------------------------------------------------------------------------------
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "zplug/zplug", hook-build:'zplug --self-manage'
zplug "plugins/asdf", from:oh-my-zsh, defer:2
zplug "plugins/docker", from:oh-my-zsh, defer:2
# zplug "plugins/docker-compose", from:oh-my-zsh, defer:2
zplug "plugins/gitignore", from:oh-my-zsh, defer:2
zplug "plugins/golang", from:oh-my-zsh, defer:3
zplug "plugins/npm", from:oh-my-zsh, defer:2
zplug "plugins/pip", from:oh-my-zsh, defer:3
zplug "plugins/tmux", from:oh-my-zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "djui/alias-tips", defer:3
zplug "darvid/zsh-poetry"  # https://github.com/darvid/zsh-poetry
zplug "g-plane/zsh-yarn-autocompletions", hook-build:"./zplug.zsh", defer:2
zplug "jimeh/zsh-peco-history", defer:2
zplug load
