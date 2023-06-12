#!/bin/bash

# Replace any placeholder text from the repo
sed -i "s|HOME_FOLDER_PATH|$HOME|" $HOME/.config/direnv/direnv.toml

# zsh profile and environment variables
cp $HOME/.config/zsh/.zshenv $HOME

# Copy all managed config, update existing files, and show progress
rsync -ahuv --progress .config/ $HOME/.config/

# iTerm2 Shell Integration & Utilities script
curl -L https://iterm2.com/shell_integration/zsh -o $HOME/.config/iterm2/iterm2_shell_integration.zsh

# tmux config
git clone https://github.com/tmux-plugins/tpm $HOME/.local/share/tmux/plugins/tpm
$HOME/.local/share/tmux/plugins/tpm/scripts/install_plugins.sh

# CLEAN UP FOR GIT
sed -i "s|$HOME|HOME_FOLDER_PATH|" $HOME/.config/direnv/direnv.toml
