#!/bin/bash

start=$(date +%s)
bold=$(tput bold)
normal=$(tput sgr0)
red=$(tput setaf 1)
green=$(tput setaf 2)
reset=$(tput sgr0)

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
ZSH="$HOME/.config/oh-my-zsh" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
# Install zplug
brew install zplug

beginDeploy "############# General Tools #############"

GeneralToolList=(
	gallery-dl # https://formulae.brew.sh/formula/gallery-dl
	youtube-dl # https://formulae.brew.sh/formula/youtube-dl
)
CaskGeneralToolList=(
	backblaze   # https://formulae.brew.sh/cask/backblaze
	deluge      # https://formulae.brew.sh/cask/deluge
	discord     # https://formulae.brew.sh/cask/discord
	firefox     # https://formulae.brew.sh/cask/firefox
	protonvpn   # https://formulae.brew.sh/cask/protonvpn
	qlcolorcode # QuickLook "extras"  # https://formulae.brew.sh/cask/qlcolorcode
	signal      # https://formulae.brew.sh/cask/signal
	spotify     # https://formulae.brew.sh/cask/spotify
	steam       # https://formulae.brew.sh/cask/steam
	telegram    # https://formulae.brew.sh/cask/telegram
	vivaldi     # https://formulae.brew.sh/cask/vivaldi
	vlc         # https://formulae.brew.sh/cask/vlc
)
brew install ${GeneralToolList[@]}
brew install --cask ${CaskGeneralToolList[@]}

beginDeploy "############# Media Tools and Players #############"

CaskMediaToolList=(
	audacity # https://formulae.brew.sh/cask/audacity
	figma    # https://formulae.brew.sh/cask/figma
	fontbase # https://formulae.brew.sh/cask/fontbase
	gimp     # https://formulae.brew.sh/cask/gimp
	inkscape # https://formulae.brew.sh/cask/inkscape
)
brew install --cask ${CaskMediaToolList[@]}

beginDeploy "############# Developer Utilities #############"

DeveloperUtilitiesList=(
	act                           # https://formulae.brew.sh/formula/act
	asdf                          # https://formulae.brew.sh/formula/asdf
	bat                           # https://formulae.brew.sh/formula/bat
	bottom                        # https://formulae.brew.sh/formula/bottom
	commitizen                    # https://formulae.brew.sh/formula/commitizen
	ctop                          # https://formulae.brew.sh/formula/ctop
	diff-so-fancy                 # https://formulae.brew.sh/formula/diff-so-fancy
	direnv                        # https://formulae.brew.sh/formula/direnv
	elixir                        # https://formulae.brew.sh/formula/elixir
	entr                          # https://formulae.brew.sh/formula/entr
	exa                           # https://formulae.brew.sh/formula/exa
	fd                            # https://formulae.brew.sh/formula/fd
	font-hack-nerd-font           # https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-hack-nerd-font.rb
	font-jetbrains-mono-nerd-font # https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-jetbrains-mono-nerd-font.rb
	fzf                           # https://formulae.brew.shh/formula/fzf
	httpie                        # https://formulae.brew.sh/formula/httpie
	ipython                       # https://formulae.brew.sh/formula/ipython
	jq                            # https://formulae.brew.sh/formula/jq
	gh                            # https://formulae.brew.sh/formula/gh
	glow                          # https://formulae.brew.sh/formula/glow
	go                            # https://formulae.brew.sh/formula/go
	lazygit                       # https://formulae.brew.sh/formula/lazygit
	magic-wormhole                # https://formulae.brew.sh/formula/magic-wormhole
	mackup                        # https://formulae.brew.sh/formula/mackup
	mcfly                         # https://formulae.brew.sh/formula/mcfly
	neovim                        # https://formulae.brew.sh/formula/neovim
	netcat                        # https://formulae.brew.sh/formula/netcat
	nmap                          # https://formulae.brew.sh/formula/nmap
	peco                          # https://formulae.brew.sh/formula/peco
	pipx                          # https://formulae.brew.sh/formula/pipx
	poetry                        # https://formulae.brew.sh/formula/poetry
	pre-commit                    # https://formulae.brew.sh/formula/pre-commit
	ripgrep                       # https://formulae.brew.sh/formula/ripgrep
	rm-improved                   # https://formulae.brew.sh/formula/rm-improved
	rust                          # https://formulae.brew.sh/formula/rust
	starship                      # https://formulae.brew.sh/formula/starship
	thefuck                       # https://formulae.brew.sh/formula/thefuck
	tmux                          # https://formulae.brew.sh/formula/tmux
	tree                          # https://formulae.brew.sh/formula/tree
	wget                          # https://formulae.brew.sh/formula/wget
	yarn                          # https://formulae.brew.sh/formula/yarn
	yarn-completion               # https://formulae.brew.sh/formula/yarn-completion
	zoxide                        # https://formulae.brew.sh/formula/zoxide
)
CaskDeveloperUtilitiesList=(
	android-studio            # https://formulae.brew.sh/cask/android-studio
	balenaetcher              # https://formulae.brew.sh/cask/balenaetcher
	chromium                  # https://formulae.brew.sh/cask/chromium
	cyberduck                 # https://formulae.brew.sh/cask/cyberduck
	firefox-developer-edition # https://formulae.brew.sh/cask/firefox-developer-edition
	flutter                   # https://formulae.brew.sh/cask/flutter
	fork                      # https://formulae.brew.sh/cask/fork
	httpie                    # https://formulae.brew.sh/cask/httpie
	iterm2                    # https://formulae.brew.sh/cask/iterm2
	kitty                     # https://formulae.brew.sh/cask/kitty
	postman                   # https://formulae.brew.sh/cask/postman
	visual-studio-code        # https://formulae.brew.sh/cask/visual-studio-code
	wireshark                 # https://formulae.brew.sh/cask/wireshark
)
brew install ${DeveloperUtilitiesList[@]}
brew install --cask ${CaskDeveloperUtilitiesList[@]}

beginDeploy "############# Database Tools #############"

DatabaseToolList=(
	postgis # https://formulae.brew.sh/formula/postgis
)
CaskDatabaseToolList=(
	dbeaver-community   # https://formulae.brew.sh/cask/dbeaver-community
	postgres-unofficial # https://formulae.brew.sh/cask/postgres-unofficial
	postico             # https://formulae.brew.sh/cask/postico
	studio-3t           # https://formulae.brew.sh/cask/studio-3t
	tableplus           # https://formulae.brew.sh/cask/tableplus
)
brew install ${DatabaseToolList[@]}
brew install --cask ${CaskDatabaseToolList[@]}

beginDeploy "############# DevOps #############"

DevOpsToolList=(
	awscli     # https://formulae.brew.sh/formula/awscli
	flyctl     # https://formulae.brew.sh/formula/flyctl
	localstack # https://formulae.brew.sh/formula/localstack
	railway    # https://formulae.brew.sh/formula/railway
	terraform  # https://formulae.brew.sh/formula/terraform
	vault      # https://formulae.brew.sh/formula/vault
	vercel-cli # https://formulae.brew.sh/formula/vercel-cli
)
CaskDevOpsToolList=(
	docker # https://formulae.brew.sh/cask/docker
	utm    # https://formulae.brew.sh/cask/utm
)
brew install ${DevOpsToolList[@]}
brew install --cask ${CaskDevOpsToolList[@]}

beginDeploy "############# Productivity Tools #############"

ProductivityToolList=(
	logi-options-plus      # https://github.com/Homebrew/homebrew-cask-drivers/blob/master/Casks/logi-options-plus.rb
	yubico-yubikey-manager # https://github.com/Homebrew/homebrew-cask-drivers/blob/master/Casks/yubico-yubikey-manager.rb
)
CaskProductivityToolList=(
	1password     # https://formulae.brew.sh/cask/1password
	1password-cli # https://formulae.brew.sh/cask/1password-cli
	anydo         # https://formulae.brew.sh/cask/anydo
	authy         # https://formulae.brew.sh/cask/authy
	gpg-suite     # https://formulae.brew.sh/cask/gpg-suite
	keka          # https://formulae.brew.sh/cask/keka
	linear-linear # https://formulae.brew.sh/cask/linear-linear
	maccy         # https://formulae.brew.sh/cask/maccy
	notion        # https://formulae.brew.sh/cask/notion
	raycast       # https://formulae.brew.sh/cask/raycast
	rectangle     # https://formulae.brew.sh/cask/rectangle
	slack         # https://formulae.brew.sh/cask/slack
	zoomus        # https://formulae.brew.sh/cask/zoomus
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

# Add asdf plugins
asdf plugin add python
asdf plugin add nodejs
asdf plugin add erlang
asdf plugin add elixir
asdf plugin add postgres
asdf plugin add direnv

# Add fzf key bindings and fuzzy completion
$(brew --prefix)/opt/fzf/install --xdg --no-bash --no-fish --key-bindings --completion --no-update-rc

beginDeploy "############# Global git config #############"

git config --global user.name $GitName
git config --global user.email $GitEmail
git config --global init.defaultBranch master
git config --global color.branch auto
git config --global color.diff auto
git config --global color.interactive auto
git config --global color.status auto
git config --global --add --bool push.autoSetupRemote true

# TODO: Introduce mackup for backups
runtime=$((($(date +%s) - $start) / 60))

beginDeploy "############# Total Setup Time ############# $runtime Minutes"

beginDeploy "############# Copy over preferences and config #############"

# TODO: Introduce mackup for backups

# Preferences managed through defaults
defaults import -app Maccy ./preferences/Maccy
defaults import -app iTerm ./preferences/iTerm
defaults import -app Rectangle ./preferences/Rectangle

./config.sh

echo "Remember to open nvim and tmux, with prefix + I, to install plugins"
