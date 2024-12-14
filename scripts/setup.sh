#!/bin/bash

# TODO: Export this pretty stuff
start=$(date +%s)
bold=$(tput bold)
normal=$(tput sgr0)
red=$(tput setaf 1)
green=$(tput setaf 2)
# reset=$(tput sgr0)

display_message() {
	echo
	echo "${bold}${green}$1${normal}"
}
error_message() {
	echo
	echo "${bold}${red}$1${normal}"
}

if test ! "$(which gcc)"; then
	echo "Installing command line developer tools..."
	xcode-select --install
fi

if test ! "$(which brew)"; then
	echo "Installing homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	brew tap homebrew/bundle
	brew tap homebrew/services
	brew tap libsql/sqld
	brew tap oven-sh/bun
fi

echo "Updating homebrew..."
brew update
brew upgrade

display_message "############# Shell Stuff #############"

# Install zsh
brew install zsh

# Install stow and get that out the way
brew install stow
mkdir "$HOME"/.dotfiles
stow --dir="$HOME"/.dotfiles --target="$HOME"

display_message "############# General Tools #############"

GeneralToolList=(
	gallery-dl # https://formulae.brew.sh/formula/gallery-dl
	youtube-dl # https://formulae.brew.sh/formula/youtube-dl
)
CaskGeneralToolList=(
	arc         # https://formulae.brew.sh/cask/arc
	backblaze   # https://formulae.brew.sh/cask/backblaze
	deluge      # https://formulae.brew.sh/cask/deluge
	discord     # https://formulae.brew.sh/cask/discord
	firefox     # https://formulae.brew.sh/cask/firefox
	protonvpn   # https://formulae.brew.sh/cask/protonvpn
	qlcolorcode # https://formulae.brew.sh/cask/qlcolorcode # QuickLook "extras"
	signal      # https://formulae.brew.sh/cask/signal
	spotify     # https://formulae.brew.sh/cask/spotify
	steam       # https://formulae.brew.sh/cask/steam
	telegram    # https://formulae.brew.sh/cask/telegram
	vlc         # https://formulae.brew.sh/cask/vlc
)
brew install "${GeneralToolList[@]}"
brew install --cask "${CaskGeneralToolList[@]}"

display_message "############# Fonts, Media Tools and Players #############"

FontList=(
	font-commit-mono-nerd-font    # https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-commit-mono-nerd-font.rb
	font-hack-nerd-font           # https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-hack-nerd-font.rb
	font-iosevka-nerd-font        # https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-iosevka-nerd-font.rb
	font-jetbrains-mono-nerd-font # https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-jetbrains-mono-nerd-font.rb
	font-lilex-nerd-font          # https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-lilex-nerd-font.rb
	font-space-mono-nerd-font     # https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-space-mono-nerd-font.rb
)

CaskMediaToolList=(
	audacity # https://formulae.brew.sh/cask/audacity
	figma    # https://formulae.brew.sh/cask/figma
	fontbase # https://formulae.brew.sh/cask/fontbase
	gimp     # https://formulae.brew.sh/cask/gimp
	inkscape # https://formulae.brew.sh/cask/inkscape
)
brew install "${FontList[@]}"
brew install --cask "${CaskMediaToolList[@]}"

display_message "############# Developer Utilities #############"

DeveloperUtilitiesList=(
	act              # https://formulae.brew.sh/formula/act
	age              # https://formulae.brew.sh/formula/age
	asdf             # https://formulae.brew.sh/formula/asdf
	bat              # https://formulae.brew.sh/formula/bat
	bottom           # https://formulae.brew.sh/formula/bottom
	bun              # https://formulae.brew.sh/formula/bun
	commitizen       # https://formulae.brew.sh/formula/commitizen
	ctop             # https://formulae.brew.sh/formula/ctop
	diff-so-fancy    # https://formulae.brew.sh/formula/diff-so-fancy
	direnv           # https://formulae.brew.sh/formula/direnv
	elixir           # https://formulae.brew.sh/formula/elixir
	entr             # https://formulae.brew.sh/formula/entr
	fd               # https://formulae.brew.sh/formula/fd
	fzf              # https://formulae.brew.shh/formula/fzf
	gh               # https://formulae.brew.sh/formula/gh
	git-delta        # https://formulae.brew.sh/formula/git-delta
	git-lfs          # https://formulae.brew.sh/formula/git-lfs
	glow             # https://formulae.brew.sh/formula/glow
	gnu-sed          # https://formulae.brew.sh/formula/gnu-sed
	go               # https://formulae.brew.sh/formula/go
	hugo             # https://formulae.brew.sh/formula/hugo
	ipython          # https://formulae.brew.sh/formula/ipython
	jq               # https://formulae.brew.sh/formula/jq
	just             # https://formulae.brew.sh/formula/just
	lazydocker       # https://formulae.brew.sh/formula/lazydocker
	lazygit          # https://formulae.brew.sh/formula/lazygit
	lsd              # https://formulae.brew.sh/formula/lsd
	mackup           # https://formulae.brew.sh/formula/mackup
	magic-wormhole   # https://formulae.brew.sh/formula/magic-wormhole
	mcfly            # https://formulae.brew.sh/formula/mcfly
	neovim           # https://formulae.brew.sh/formula/neovim
	netcat           # https://formulae.brew.sh/formula/netcat
	nmap             # https://formulae.brew.sh/formula/nmap
	peco             # https://formulae.brew.sh/formula/peco
	pipx             # https://formulae.brew.sh/formula/pipx
	poetry           # https://formulae.brew.sh/formula/poetry
	pre-commit       # https://formulae.brew.sh/formula/pre-commit
	ripgrep          # https://formulae.brew.sh/formula/ripgrep
	rm-improved      # https://formulae.brew.sh/formula/rm-improved
	rustup-init      # https://formulae.brew.sh/formula/rustup-init
	silicon          # https://formulae.brew.sh/formula/silicon
	source-highlight # https://formulae.brew.sh/formula/source-highlight
	starship         # https://formulae.brew.sh/formula/starship
	tailwindcss      # https://formulae.brew.sh/formula/tailwindcss
	thefuck          # https://formulae.brew.sh/formula/thefuck
	tmux             # https://formulae.brew.sh/formula/tmux
	tree             # https://formulae.brew.sh/formula/tree
	wget             # https://formulae.brew.sh/formula/wget
	yarn             # https://formulae.brew.sh/formula/yarn
	yarn-completion  # https://formulae.brew.sh/formula/yarn-completion
	yq               # https://formulae.brew.sh/formula/yq
	zoxide           # https://formulae.brew.sh/formula/zoxide
)
CaskDeveloperUtilitiesList=(
	android-studio            # https://formulae.brew.sh/cask/android-studio
	balenaetcher              # https://formulae.brew.sh/cask/balenaetcher
	chromium                  # https://formulae.brew.sh/cask/chromium
	cyberduck                 # https://formulae.brew.sh/cask/cyberduck
	firefox@developer-edition # https://formulae.brew.sh/cask/firefox@developer-edition
	flutter                   # https://formulae.brew.sh/cask/flutter
	fork                      # https://formulae.brew.sh/cask/fork
	iterm2                    # https://formulae.brew.sh/cask/iterm2
	kitty                     # https://formulae.brew.sh/cask/kitty
	macfuse                   # https://formulae.brew.sh/cask/macfuse
	postman                   # https://formulae.brew.sh/cask/postman
	visual-studio-code        # https://formulae.brew.sh/cask/visual-studio-code
	wireshark                 # https://formulae.brew.sh/cask/wireshark
)
brew install "${DeveloperUtilitiesList[@]}"
brew install --cask "${CaskDeveloperUtilitiesList[@]}"

display_message "############# Database Tools #############"

DatabaseToolList=(
	libspatialite # https://formulae.brew.sh/formula/libspatialite
	postgis       # https://formulae.brew.sh/formula/postgis
	valkey        # https://formulae.brew.sh/formula/valkey
)
CaskDatabaseToolList=(
	beekeeper-studio    # https://formulae.brew.sh/cask/beekeeper-studio
	dbeaver-community   # https://formulae.brew.sh/cask/dbeaver-community
	postgres-unofficial # https://formulae.brew.sh/cask/postgres-unofficial
	postico             # https://formulae.brew.sh/cask/postico
	studio-3t           # https://formulae.brew.sh/cask/studio-3t
	tableplus           # https://formulae.brew.sh/cask/tableplus
)
brew install "${DatabaseToolList[@]}"
brew install --cask "${CaskDatabaseToolList[@]}"

display_message "############# DevOps #############"

DevOpsToolList=(
	awscli     # https://formulae.brew.sh/formula/awscli
	flyctl     # https://formulae.brew.sh/formula/flyctl
	k9s        # https://formulae.brew.sh/formula/k9s
	localstack # https://formulae.brew.sh/formula/localstack
	opentofu   # https://formulae.brew.sh/formula/opentofu
	oxker      # https://formulae.brew.sh/formula/oxker
	railway    # https://formulae.brew.sh/formula/railway
	terraform  # https://formulae.brew.sh/formula/terraform
	vault      # https://formulae.brew.sh/formula/vault
)
CaskDevOpsToolList=(
	docker   # https://formulae.brew.sh/cask/docker
	orbstack # https://formulae.brew.sh/cask/orbstack
)
brew install "${DevOpsToolList[@]}"
brew install --cask "${CaskDevOpsToolList[@]}"

display_message "############# Productivity Tools #############"

ProductivityToolList=(
	logi-options-plus      # https://github.com/Homebrew/homebrew-cask-drivers/blob/master/Casks/logi-options-plus.rb
	syncthing              # https://formulae.brew.sh/formula/syncthing
	yubico-yubikey-manager # https://github.com/Homebrew/homebrew-cask-drivers/blob/master/Casks/yubico-yubikey-manager.rb
)
CaskProductivityToolList=(
	1password     # https://formulae.brew.sh/cask/1password
	1password-cli # https://formulae.brew.sh/cask/1password-cli
	keka          # https://formulae.brew.sh/cask/keka
	linear-linear # https://formulae.brew.sh/cask/linear-linear
	maccy         # https://formulae.brew.sh/cask/maccy
	obsidian      # https://formulae.brew.sh/cask/obsidian
	raycast       # https://formulae.brew.sh/cask/raycast
	rectangle     # https://formulae.brew.sh/cask/rectangle
	slack         # https://formulae.brew.sh/cask/slack
	zoom          # https://formulae.brew.sh/cask/zoom
)
brew install "${ProductivityToolList[@]}"
brew install --cask "${CaskProductivityToolList[@]}"

############# Mac Application #############
display_message "############# macOS Applications #############"

MacApplicationToolList=(
	1549557075 # HacKit
	409183694  # Keynote
	409203825  # Numbers
	409201541  # Pages
	497799835  # Xcode
)
brew install mas
mas install "${MacApplicationToolList[@]}"

display_message "############# Cleaning Up #############"
brew cleanup

# Add asdf plugins
asdf plugin add python
asdf plugin add nodejs
asdf plugin add erlang
asdf plugin add elixir
asdf plugin add gleam
asdf plugin add postgres
asdf plugin add direnv

runtime=$((($(date +%s) - start) / 60))

display_message "############# Total Setup Time ############# $runtime Minutes"

display_message "############# Copy over preferences and config #############"

./config.sh

echo "Remember to install TPM (https://github.com/tmux-plugins/tpm) before opening tmux"
echo "Remember to also install SSHFS because life is hard for some reason (https://osxfuse.github.io/)."
echo "Remember to open nvim and tmux, with prefix + I, to install plugins"
