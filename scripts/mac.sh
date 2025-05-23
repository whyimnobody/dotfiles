#!/bin/bash

start=$(date +%s)

# Import my functions, including the install_package function and coloured stdout functions
source ../.config/zsh/scripts/functions.zsh

# --- Define stuff for the database ---
PACKAGES_DATABASE="$XDG_STATE_HOME/dotfiles/dotfiles.db"
# --- Initialize the package tracking database if it doesn't exist ---
if [ ! -f "$PACKAGES_DATABASE" ]; then
	mkdir -p "$XDG_STATE_HOME/dotfiles"
	touch "$PACKAGES_DATABASE"
	sqlite3 "$PACKAGES_DATABASE" "CREATE TABLE IF NOT EXISTS packages (name TEXT, type TEXT, PRIMARY KEY (name, type));"
fi
# --- Ensure the stuff we need is here ---
if test ! "$(which gcc)"; then
	display_message "############# Cleaning Up #############"
	info "Installing command line developer tools..."
	xcode-select --install
fi
# --- Install Homebrew if required
if test ! "$(which brew)"; then
	info "Installing homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

info "Updating homebrew..."
brew update
brew upgrade

brew_general=(
	gallery-dl # https://formulae.brew.sh/formula/gallery-dl
	yt-dlp     # https://formulae.brew.sh/formula/yt-dlp
)
brew_fonts=(
	font-cascadia-code            # https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-cascadia-code.rb
	font-caskaydia-cove-nerd-font # https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-caskaydia-cove-nerd-font.rb
	font-commit-mono-nerd-font    # https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-commit-mono-nerd-font.rb
	font-hack-nerd-font           # https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-hack-nerd-font.rb
	font-iosevka-nerd-font        # https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-iosevka-nerd-font.rb
	font-jetbrains-mono-nerd-font # https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-jetbrains-mono-nerd-font.rb
	font-lilex-nerd-font          # https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-lilex-nerd-font.rb
	font-space-mono-nerd-font     # https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-space-mono-nerd-font.rb
	font-symbols-only-nerd-font   # https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-symbols-only-nerd-font.rb
)
brew_dev=(
	act              # https://formulae.brew.sh/formula/act
	age              # https://formulae.brew.sh/formula/age
	bat              # https://formulae.brew.sh/formula/bat
	bottom           # https://formulae.brew.sh/formula/bottom
	commitizen       # https://formulae.brew.sh/formula/commitizen
	croc             # https://formulae.brew.sh/formula/croc
	ctop             # https://formulae.brew.sh/formula/ctop
	diff-so-fancy    # https://formulae.brew.sh/formula/diff-so-fancy
	direnv           # https://formulae.brew.sh/formula/direnv
	elixir           # https://formulae.brew.sh/formula/elixir
	entr             # https://formulae.brew.sh/formula/entr
	fd               # https://formulae.brew.sh/formula/fd
	ffmpeg           # https://formulae.brew.sh/formula/ffmpeg
	fzf              # https://formulae.brew.shh/formula/fzf
	git-delta        # https://formulae.brew.sh/formula/git-delta
	git-lfs          # https://formulae.brew.sh/formula/git-lfs
	glow             # https://formulae.brew.sh/formula/glow
	gnu-sed          # https://formulae.brew.sh/formula/gnu-sed
	go               # https://formulae.brew.sh/formula/go
	hugo             # https://formulae.brew.sh/formula/hugo
	imagemagick      # https://formulae.brew.sh/formula/imagemagick
	ipython          # https://formulae.brew.sh/formula/ipython
	jq               # https://formulae.brew.sh/formula/jq
	just             # https://formulae.brew.sh/formula/just
	lazydocker       # https://formulae.brew.sh/formula/lazydocker
	lazygit          # https://formulae.brew.sh/formula/lazygit
	lazysql          # https://formulae.brew.sh/formula/lazysql
	lsd              # https://formulae.brew.sh/formula/lsd
	neovim           # https://formulae.brew.sh/formula/neovim
	netcat           # https://formulae.brew.sh/formula/netcat
	nmap             # https://formulae.brew.sh/formula/nmap
	peco             # https://formulae.brew.sh/formula/peco
	poppler          # https://formulae.brew.sh/formula/poppler
	pre-commit       # https://formulae.brew.sh/formula/pre-commit
	resvg            # https://formulae.brew.sh/formula/resvg
	ripgrep          # https://formulae.brew.sh/formula/ripgrep
	rm-improved      # https://formulae.brew.sh/formula/rm-improved
	rustup           # https://formulae.brew.sh/formula/rustup
	silicon          # https://formulae.brew.sh/formula/silicon
	source-highlight # https://formulae.brew.sh/formula/source-highlight
	starship         # https://formulae.brew.sh/formula/starship
	stow             # https://formulae.brew.sh/formula/stow
	tailwindcss      # https://formulae.brew.sh/formula/tailwindcss
	tlrc             # https://formulae.brew.sh/formula/tlrc
	tmux             # https://formulae.brew.sh/formula/tmux
	tree             # https://formulae.brew.sh/formula/tree
	uv               # https://formulae.brew.sh/formula/uv
	wget             # https://formulae.brew.sh/formula/wget
	yarn             # https://formulae.brew.sh/formula/yarn
	yarn-completion  # https://formulae.brew.sh/formula/yarn-completion
	yazi             # https://formulae.brew.sh/formula/yazi
	yq               # https://formulae.brew.sh/formula/yq
	zoxide           # https://formulae.brew.sh/formula/zoxide
	zsh              # https://formulae.brew.sh/formula/zsh
)
brew_devops=(
	awscli   # https://formulae.brew.sh/formula/awscli
	flyctl   # https://formulae.brew.sh/formula/flyctl
	k9s      # https://formulae.brew.sh/formula/k9s
	opentofu # https://formulae.brew.sh/formula/opentofu
)
brew_databases=(
	libsql   # https://formulae.brew.sh/formula/libsql
	pgvector # https://formulae.brew.sh/formula/pgvector
	postgis  # https://formulae.brew.sh/formula/postgis
	valkey   # https://formulae.brew.sh/formula/valkey
)
brew_productivity=(
	logi-options-plus      # https://github.com/Homebrew/homebrew-cask-drivers/blob/master/Casks/logi-options-plus.rb
	syncthing              # https://formulae.brew.sh/formula/syncthing
	yubico-yubikey-manager # https://github.com/Homebrew/homebrew-cask-drivers/blob/master/Casks/yubico-yubikey-manager.rb
)

casks_general=(
	brave-browser # https://formulae.brew.sh/cask/brave-browser
	backblaze     # https://formulae.brew.sh/cask/backblaze
	librewolf     # https://formulae.brew.sh/cask/librewolf
	protonvpn     # https://formulae.brew.sh/cask/protonvpn
	qbittorrent   # https://formulae.brew.sh/cask/qbittorrent
	qlcolorcode   # https://formulae.brew.sh/cask/qlcolorcode # QuickLook "extras"
	signal        # https://formulae.brew.sh/cask/signal
	steam         # https://formulae.brew.sh/cask/steam
	telegram      # https://formulae.brew.sh/cask/telegram
	zen-browser   # https://formulae.brew.sh/cask/zen-browser
)
casks_media=(
	audacity # https://formulae.brew.sh/cask/audacity
	figma    # https://formulae.brew.sh/cask/figma
	fontbase # https://formulae.brew.sh/cask/fontbase
	gimp     # https://formulae.brew.sh/cask/gimp
	inkscape # https://formulae.brew.sh/cask/inkscape
	spotify  # https://formulae.brew.sh/cask/spotify
	vlc      # https://formulae.brew.sh/cask/vlc
)
casks_dev=(
	balenaetcher       # https://formulae.brew.sh/cask/balenaetcher
	cyberduck          # https://formulae.brew.sh/cask/cyberduck
	fork               # https://formulae.brew.sh/cask/fork
	visual-studio-code # https://formulae.brew.sh/cask/visual-studio-code
)
casks_devops=(
	# docker   # https://formulae.brew.sh/cask/docker
	orbstack # https://formulae.brew.sh/cask/orbstack
)
casks_databases=(
	beekeeper-studio    # https://formulae.brew.sh/cask/beekeeper-studio
	dbeaver-community   # https://formulae.brew.sh/cask/dbeaver-community
	postgres-unofficial # https://formulae.brew.sh/cask/postgres-unofficial
	postico             # https://formulae.brew.sh/cask/postico
	tableplus           # https://formulae.brew.sh/cask/tableplus
)
casks_productivity=(
	1password     # https://formulae.brew.sh/cask/1password
	1password-cli # https://formulae.brew.sh/cask/1password-cli
	keka          # https://formulae.brew.sh/cask/keka
	linear-linear # https://formulae.brew.sh/cask/linear-linear
	maccy         # https://formulae.brew.sh/cask/maccy
	obsidian      # https://formulae.brew.sh/cask/obsidian
	raycast       # https://formulae.brew.sh/cask/raycast
	rectangle     # https://formulae.brew.sh/cask/rectangle
	zoom          # https://formulae.brew.sh/cask/zoom
)

# For AppStore Apps
brew install mas
app_store_apps=(
	1549557075 # HacKit
	409183694  # Keynote
	409203825  # Numbers
	409201541  # Pages
	497799835  # Xcode
)
formulae=(
	"${brew_general[@]}"
	"${brew_fonts[@]}"
	"${brew_dev[@]}"
	"${brew_devops[@]}"
	"${brew_databases[@]}"
	"${brew_productivity[@]}"
)
casks=(
	"${casks_general[@]}"
	"${casks_media[@]}"
	"${casks_dev[@]}"
	"${casks_devops[@]}"
	"${casks_databases[@]}"
	"${casks_productivity[@]}"
)
gophers=()
crates=()

# Install packages
info "Let's get to the hard stuff"
for package in "${app_store_apps[@]}"; do install_package "$package" "app_store"; done
for package in "${formulae[@]}"; do install_package "$package" "formula"; done
for package in "${casks[@]}"; do install_package "$package" "cask"; done
for package in "${gophers[@]}"; do install_package "$package" "go"; done
for package in "${crates[@]}"; do install_package "$package" "rust"; done

# Additional commands for installations, because macOS (fucking Apple fucks)
warning "Let Zen be zen (fucking Apple fucks)"
xattr -d com.apple.quarantine '/Applications/Zen Browser.app/'

# Adding `opentofu` to PATH as drop-in replacement for `terraform`
sudo ln -sf "$(which tofu)" /usr/local/bin/terraform

# Install TPM
if [ ! -d "$HOME/.local/share/tmux/plugins/tpm/" ]; then
	info "Install tmux and plugins"
	git clone "https://github.com/tmux-plugins/tpm" ~/.local/share/tmux/plugins/tpm
	stow --dir="$HOME"/.dotfiles --target="$HOME" tmux
	"$HOME"/.local/share/tmux/plugins/tpm/scripts/install_plugins.sh
fi

# Sort out stowed packages
info "Stowing packages"
stow --dir="$HOME"/.dotfiles --target="$HOME" dev git terminal tmux zsh

success "############# Cleaning Up #############"
brew cleanup

runtime=$((($(date +%s) - start) / 60))

success "############# Total Setup Time ############# $runtime Minutes"
