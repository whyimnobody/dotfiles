#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)
red=$(tput setaf 1)
green=$(tput setaf 2)

display_message() {
	echo
	echo "${bold}${green}$1${normal}"
}
error_message() {
	echo
	echo "${bold}${red}$1${normal}"
}

echo "What's your git name?"
read -r GitName
echo "What's your git email address?"
read -r GitEmail

display_message "############# Global git config #############"

git config --global user.name "$GitName"
git config --global user.email "$GitEmail"
git config --global init.defaultBranch main
git config --global color.branch auto
git config --global color.diff auto
git config --global color.interactive auto
git config --global color.status auto
git config --global --add --bool push.autoSetupRemote true
# Sort out git-lfs error. src: https://stackoverflow.com/questions/67395259/git-clone-git-lfs-filter-process-git-lfs-command-not-found#answer-69007609
ln -s "$(which git-lfs)" "$(git --exec-path)/git-lfs"

# Save screenshots to ${HOME}/Downloads/Screenshots in PNG
defaults write com.apple.screencapture location -string "${HOME}/Downloads/Screenshots"
defaults write com.apple.screencapture type -string "png"

# Copy all managed config, update existing files, and show progress
rsync -ahuv --progress .config/ "$HOME"/.config/

# Add fzf key bindings and fuzzy completion
"$(brew --prefix)"/opt/fzf/install --xdg --no-bash --no-fish --key-bindings --completion --no-update-rc

# zsh profile and environment variables
cp "$HOME"/.config/dotfiles/.zshenv "$HOME"
# Set default shell to zsh
chsh -s "$(which zsh)"

# iTerm2 Shell Integration & Utilities script
curl -L https://iterm2.com/shell_integration/zsh -o "$HOME"/.config/iterm2/iterm2_shell_integration.zsh

# tmux config
git clone https://github.com/tmux-plugins/tpm /tmp/tpm
mv f /tmp/tpm "$HOME"/.local/share/tmux/plugins/tpm
"$HOME"/.local/share/tmux/plugins/tpm/scripts/install_plugins.sh

# TODO: Introduce mackup for backups / Assess stow for these as well
# Preferences managed through defaults
# defaults import -app Maccy ./preferences/Maccy
# defaults import -app iTerm ./preferences/iTerm
# defaults import -app Rectangle ./preferences/Rectangle
