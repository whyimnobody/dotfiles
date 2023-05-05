# PLUGINS
# ------------------------------------------------------------------------------
# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(alias-tips asdf autoenv aws brew django docker docker-compose fabric git git-flow github history jsontools kubectl node npm osx pip python thefuck vscode yarn zsh-autosuggestions zsh-syntax-highlighting)

# zplug settings and sourcing
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh

# Intentionally excluded plugins: fabric|git-flow|github|kubectl|node|osx|python|vscode|yarn
zplug "zplug/zplug", hook-build:'zplug --self-manage'
zplug "djui/alias-tips", defer:3
zplug "kiurchv/asdf.plugin.zsh", defer:3
# zplug "Tarrasch/zsh-autoenv"
zplug "plugins/aws", from:oh-my-zsh, defer:2
zplug "plugins/brew", from:oh-my-zsh, defer:2
zplug "plugins/brew-cask", from:oh-my-zsh, defer:2
zplug "plugins/docker", from:oh-my-zsh, defer:2
zplug "plugins/docker-compose", from:oh-my-zsh, defer:2
zplug "plugins/git", from:oh-my-zsh, defer:2
zplug "plugins/gitignore", from:oh-my-zsh, defer:2
zplug "plugins/golang", from:oh-my-zsh, defer:3
zplug "plugins/npm", from:oh-my-zsh, defer:2
zplug "plugins/pip", from:oh-my-zsh, defer:3
zplug "darvid/zsh-poetry"
zplug 'anonguy/yapipenv.zsh', defer:1
zplug "laggardkernel/zsh-thefuck", defer:3
zplug "plugins/tmux", from:oh-my-zsh
zplug "g-plane/zsh-yarn-autocompletions", hook-build:"./zplug.zsh", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "jimeh/zsh-peco-history", defer:2
zplug "lukechilds/zsh-nvm", defer:2
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug load
