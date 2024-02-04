#!/bin/bash

echo "What's your git name?"
read GitName
echo "What's your git email address?"
read GitEmail

display_message "############# Global git config #############"

git config --global user.name $GitName
git config --global user.email $GitEmail
git config --global init.defaultBranch master
git config --global color.branch auto
git config --global color.diff auto
git config --global color.interactive auto
git config --global color.status auto
git config --global --add --bool push.autoSetupRemote true

# Save screenshots to ${HOME}/Downloads/Screenshots in PNG
defaults write com.apple.screencapture location -string "${HOME}/Downloads/Screenshots"
defaults write com.apple.screencapture type -string "png"

# Copy all managed config, update existing files, and show progress
rsync -ahuv --progress .config/ $HOME/.config/

# Add fzf key bindings and fuzzy completion
$(brew --prefix)/opt/fzf/install --xdg --no-bash --no-fish --key-bindings --completion --no-update-rc

# zsh profile and environment variables
cp $HOME/.config/zsh/.zshenv $HOME
# Set default shell to zsh
chsh -s $(which zsh)

# iTerm2 Shell Integration & Utilities script
curl -L https://iterm2.com/shell_integration/zsh -o $HOME/.config/iterm2/iterm2_shell_integration.zsh

# tmux config
git clone https://github.com/tmux-plugins/tpm $HOME/.local/share/tmux/plugins/tpm
$HOME/.local/share/tmux/plugins/tpm/scripts/install_plugins.sh

# TODO: Introduce mackup for backups

# Preferences managed through defaults
defaults import -app Maccy ./preferences/Maccy
defaults import -app iTerm ./preferences/iTerm
defaults import -app Rectangle ./preferences/Rectangle
