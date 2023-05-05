#!/bin/bash

start=`date +%s`
bold=$(tput bold)
normal=$(tput sgr0)
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

echo "What's your git name?"
read GitName
echo "What's your git email address?"
read GitEmail

if test ! $(which gcc); then
  echo "Installing command line developer tools..."
  xcode-select --install
fi

if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew tap homebrew/cask
  brew tap homebrew/core
  brew tap homebrew/bundle
  brew tap homebrew/cask-versions
  brew tap homebrew/cask-drivers
  brew tap homebrew/cask-fonts
  brew tap homebrew/services
  brew tap aws/tap
  # brew tap heroku/brew
fi

echo "Updating homebrew..."
brew update
brew upgrade


beginDeploy() {
    echo
    echo "${bold}${green}$1${normal}"
}


beginDeploy "############# Shell Stuff #############"

# Install zsh
brew install zsh
# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# Install zplug
brew install zplug
# Add aliases, application settings and zplug extensions to the config folder
cp -r zsh $HOME/.config/zsh/
# Load the separate config files into the shell
cat zsh_loader.sh >> $HOME/.zshrc


beginDeploy "############# General Tools #############"

GeneralToolList=(
    gallery-dl  # https://formulae.brew.sh/formula/gallery-dl
)
CaskGeneralToolList=(
    backblaze  # https://formulae.brew.sh/cask/backblaze
    deluge  # https://formulae.brew.sh/cask/deluge
    discord  # https://formulae.brew.sh/cask/discord
    firefox  # https://formulae.brew.sh/cask/firefox
    protonvpn  # https://formulae.brew.sh/cask/protonvpn
    qlcolorcode # QuickLook "extras"  # https://formulae.brew.sh/cask/qlcolorcode
    signal  # https://formulae.brew.sh/cask/signal
    spotify  # https://formulae.brew.sh/cask/spotify
    steam  # https://formulae.brew.sh/cask/steam
    telegram  # https://formulae.brew.sh/cask/telegram
    vivaldi  # https://formulae.brew.sh/cask/vivaldi
    vlc  # https://formulae.brew.sh/cask/    vlc
)
brew install ${GeneralToolList[@]}
brew install --cask ${CaskGeneralToolList[@]}


beginDeploy "############# Media Tools and Players #############"

CaskMediaToolList=(
    audacity  # https://formulae.brew.sh/cask/audacity
    figma  # https://formulae.brew.sh/cask/figma
    fontbase  # https://formulae.brew.sh/cask/fontbase
    gimp  # https://formulae.brew.sh/cask/gimp
    inkscape  # https://formulae.brew.sh/cask/inkscape
)
brew install --cask ${CaskMediaToolList[@]}


beginDeploy "############# Mobile Developer #############"

CaskMobileDeveloperToolList=(
    flutter  # https://formulae.brew.sh/cask/flutter
)
brew install --cask ${CaskMobileDeveloperToolList[@]}


beginDeploy "############# Developer Utilities #############"

DeveloperUtilitiesList=(
    asdf  # https://formulae.brew.sh/formula/asdf
    bat  # https://formulae.brew.sh/formula/bat
    bottom  # https://formulae.brew.sh/formula/bottom
    commitizen  # https://formulae.brew.sh/formula/commitizen
    ctop  # https://formulae.brew.sh/formula/ctop
    direnv  # https://formulae.brew.sh/formula/direnv
    elixir  # https://formulae.brew.sh/formula/elixir
    fd  # https://formulae.brew.sh/formula/fd
    font-hack-nerd-font  # https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-hack-nerd-font.rb
    font-jetbrains-mono  # https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-jetbrains-mono.rb
    font-jetbrains-mono-nerd-font  # https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-jetbrains-mono-nerd-font.rb
    fzf  # https://formulae.brew.sh/formula/fzf
    httpie  # https://formulae.brew.sh/formula/httpie
    ipython  # https://formulae.brew.sh/formula/ipython
    jq  # https://formulae.brew.sh/formula/jq
    go  # https://formulae.brew.sh/formula/go
    lazygit  # https://formulae.brew.sh/formula/lazygit
    magic-wormhole  # https://formulae.brew.sh/formula/magic-wormhole
    neovim  # https://formulae.brew.sh/formula/neovim
    netcat  # https://formulae.brew.sh/formula/netcat
    nmap  # https://formulae.brew.sh/formula/nmap
    pipx  # https://formulae.brew.sh/formula/pipx
    poetry  # https://formulae.brew.sh/formula/poetry
    pre-commit  # https://formulae.brew.sh/formula/pre-commit
    ripgrep  # https://formulae.brew.sh/formula/ripgrep
    rust  # https://formulae.brew.sh/formula/rust
    koekeishiya/formulae/skhd  # https://github.com/koekeishiya/skhd/
    thefuck  # https://formulae.brew.sh/formula/thefuck
    tmux  # https://formulae.brew.sh/formula/tmux
    tree  # https://formulae.brew.sh/formula/tree
    wget  # https://formulae.brew.sh/formula/wget
    koekeishiya/formulae/yabai  # https://github.com/koekeishiya/yabai/
    yarn  # https://formulae.brew.sh/formula/yarn
    yarn-completion  # https://formulae.brew.sh/formula/yarn-completion
    youtube-dl  # https://formulae.brew.sh/formula/youtube-dl
)
CaskDeveloperUtilitiesList=(
    alacritty  # https://formulae.brew.sh/cask/alacritty
    balenaetcher  # https://formulae.brew.sh/cask/balenaetcher
    chromium  # https://formulae.brew.sh/cask/chromium
    cyberduck  # https://formulae.brew.sh/cask/cyberduck
    fork  # https://formulae.brew.sh/cask/fork
    iterm2  # https://formulae.brew.sh/cask/iterm2
    postman  # https://formulae.brew.sh/cask/postman
    raycast  # https://formulae.brew.sh/cask/raycast
    wireshark  # https://formulae.brew.sh/cask/wireshark
    firefox-developer-edition  # https://formulae.brew.sh/cask/firefox-developer-edition
)
brew install ${DeveloperUtilitiesList[@]}
brew install --cask ${CaskDeveloperUtilitiesList[@]}


beginDeploy "############# Database Tools #############"

DatabaseToolList=(
    postgis  # https://formulae.brew.sh/formula/postgis
)
CaskDatabaseToolList=(
    dbeaver-community  # https://formulae.brew.sh/cask/dbeaver-community
    postgres-unofficial  # https://formulae.brew.sh/cask/postgres-unofficial
    postico  # https://formulae.brew.sh/cask/postico
    studio-3t  # https://formulae.brew.sh/cask/studio-3t
    tableplus  # https://formulae.brew.sh/cask/tableplus
)
brew install ${DatabaseToolList[@]}
brew install --cask ${CaskDatabaseToolList[@]}


beginDeploy "############# IDEs #############"

CaskIDEsList=(
    visual-studio-code  # https://formulae.brew.sh/cask/visual-studio-code
    pycharm-ce  # https://formulae.brew.sh/cask/pycharm-ce
    android-studio  # https://formulae.brew.sh/cask/android-studio
)
brew install --cask ${CaskIDEsList[@]}


beginDeploy "############# DevOps #############"

DevOpsToolList=(
    awscli  # https://formulae.brew.sh/formula/awscli
    flyctl  # https://formulae.brew.sh/formula/flyctl
    localstack  # https://formulae.brew.sh/formula/localstack
    railway  # https://formulae.brew.sh/formula/railway
    terraform  # https://formulae.brew.sh/formula/terraform
    vault  # https://formulae.brew.sh/formula/vault
)
CaskDevOpsToolList=(
    docker  # https://formulae.brew.sh/cask/docker
    utm  # https://formulae.brew.sh/cask/utm
)
brew install ${DevOpsToolList[@]}
brew install --cask ${CaskDevOpsToolList[@]}

beginDeploy "############# Productivity Tools #############"

ProductivityToolList=(
    logi-options-plus  # https://github.com/Homebrew/homebrew-cask-drivers/blob/master/Casks/logi-options-plus.rb
    yubico-yubikey-manager  # https://github.com/Homebrew/homebrew-cask-drivers/blob/master/Casks/yubico-yubikey-manager.rb
)
CaskProductivityToolList=(
    1password  # https://formulae.brew.sh/cask/1password
    1password-cli  # https://formulae.brew.sh/cask/1password-cli
    anydo  # https://formulae.brew.sh/cask/anydo
    authy  # https://formulae.brew.sh/cask/authy
    gpg-suite  # https://formulae.brew.sh/cask/gpg-suite
    keka  # https://formulae.brew.sh/cask/keka
    linear-linear  # https://formulae.brew.sh/cask/linear-linear
    maccy  # https://formulae.brew.sh/cask/maccy
    notion  # https://formulae.brew.sh/cask/notion
    obsidian  # https://formulae.brew.sh/cask/obsidian
    microsoft-teams  # https://formulae.brew.sh/cask/microsoft-teams
    rectangle  # https://formulae.brew.sh/cask/rectangle
    slack  # https://formulae.brew.sh/cask/slack
    zoomus  # https://formulae.brew.sh/cask/zoomus
)
brew install ${ProductivityToolList[@]}
brew install --cask ${CaskProductivityToolList[@]}


############# Mac Application #############
beginDeploy "############# macOS Applications #############"

MacApplicationToolList=(
    497799835 # Xcode
    409201541 # Pages
    409203825 # Numbers
    409183694 # Keynote
)
brew install mas
mas install ${MacApplicationToolList[@]}

echo "######### Save screenshots to ${HOME}/Downloads/Screenshots"
defaults write com.apple.screencapture location -string "${HOME}/Downloads/Screenshots"
echo "######### Save screenshots in PNG format (other options: bmp, gif, jpg, pdf, tiff"
defaults write com.apple.screencapture type -string "png"


beginDeploy "############# Cleaning Up #############"
brew cleanup

beginDeploy "############# Global git config #############"

git config --global user.name $GitName
git config --global user.email $GitEmail
git config --global init.defaultBranch master
git config --global color.branch auto
git config --global color.diff auto
git config --global color.interactive auto
git config --global color.status auto
git config --global --add --bool push.autoSetupRemote true

beginDeploy "############# Copy over preferences and config #############"
# zsh profile
cp zsh/.zshrc $HOME
# direnv preferences
cp preferences/direnv.toml $HOME/.config/direnv/direnv.toml
# iTerm2 Shell Integration & Utilities script
curl -L https://iterm2.com/shell_integration/zsh -o ~/.config/iterm2/iterm2_shell_integration.zsh
# tmux config
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp tmux/tmux.conf ~/.config/tmux/tmux.conf
~/.config/tmux/plugins/tpm/scripts/install_plugins.sh
# Preferences managed through defaults
defaults import -app Maccy ./preferences/Maccy
defaults import -app iTerm ./preferences/iTerm
defaults import -app Rectangle ./preferences/Rectangle
# Add asdf plugins
asdf plugin add python
asdf plugin add nodejs
asdf plugin add erlang
asdf plugin add elixir
asdf plugin add postgres
# Add Alacritty preferences and config
mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
cp alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

# # Add LunarVim, setup and preferences
# LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
# # mkdir -p ~/.config/lvim/lua/whyimnobody
# mkdir -p ~/.config/nvim/lua/whyimnobody
# cp nvim/config.lua ~/.config/nvim/config.lua
# cp -r nvim/lua ~/.config/nvim/lua

# TODO: Decide on starting services
# yabai --install-service
# skhd --install-service

runtime=$((($(date +%s)-$start)/60))
beginDeploy "############# Total Setup Time ############# $runtime Minutes"
