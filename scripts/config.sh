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

# Sort out git-lfs error. src: https://stackoverflow.com/questions/67395259/git-clone-git-lfs-filter-process-git-lfs-command-not-found#answer-69007609
# ln -s "$(which git-lfs)" "$(git --exec-path)/git-lfs"

# Save screenshots to ${HOME}/Downloads/Screenshots in PNG
defaults write com.apple.screencapture location -string "${HOME}/Downloads/Screenshots"
defaults write com.apple.screencapture type -string "png"

# Add fzf key bindings and fuzzy completion
"$(brew --prefix)"/opt/fzf/install --xdg --no-bash --no-fish --key-bindings --completion --no-update-rc

# Set default shell to zsh
chsh -s "$(which zsh)"

# TODO: Introduce mackup for backups / Assess stow for these as well
# Preferences managed through defaults
# defaults import -app Maccy ./preferences/Maccy
# defaults import -app Rectangle ./preferences/Rectangle
