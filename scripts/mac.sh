#!/bin/bash

start=$(date +%s)

# --- Ensure the stuff we need is here ---
if test ! "$(which gcc)"; then
	xcode-select --install
fi

# Get the dotfiles
if [ ! -d "$HOME/.dotfiles/" ]; then
	git clone "https://github.com/whyimnobody/dotfiles" ~/.dotfiles
fi

# Import my functions, including the install_package function and coloured stdout functions
source "$HOME/.dotfiles/zsh/.config/zsh/scripts/functions.zsh"
source "$HOME/.dotfiles/zsh/.zshenv"

# --- Install Homebrew if required
if test ! "$(which brew)"; then
	info "Installing homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update
brew upgrade

brew_general=(
	gallery-dl # https://formulae.brew.sh/formula/gallery-dl
	syncthing  # https://formulae.brew.sh/formula/syncthing
	yt-dlp     # https://formulae.brew.sh/formula/yt-dlp
)
casks_general=(
	1password              # https://formulae.brew.sh/cask/1password
	1password-cli          # https://formulae.brew.sh/cask/1password-cli
	backblaze              # https://formulae.brew.sh/cask/backblaze
	brave-browser          # https://formulae.brew.sh/cask/brave-browser
	keka                   # https://formulae.brew.sh/cask/keka
	librewolf              # https://formulae.brew.sh/cask/librewolf
	logi-options+          # https://formulae.brew.sh/cask/logi-options+#default
	maccy                  # https://formulae.brew.sh/cask/maccy
	obsidian               # https://formulae.brew.sh/cask/obsidian
	protonvpn              # https://formulae.brew.sh/cask/protonvpn
	qbittorrent            # https://formulae.brew.sh/cask/qbittorrent
	qlcolorcode            # https://formulae.brew.sh/cask/qlcolorcode # QuickLook "extras"
	raycast                # https://formulae.brew.sh/cask/raycast
	rectangle              # https://formulae.brew.sh/cask/rectangle
	signal                 # https://formulae.brew.sh/cask/signal
	steam                  # https://formulae.brew.sh/cask/steam
	yubico-yubikey-manager # https://formulae.brew.sh/cask/yubico-yubikey-manager#default
	zen-browser            # https://formulae.brew.sh/cask/zen-browser
	zoom                   # https://formulae.brew.sh/cask/zoom
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
	gum              # https://formulae.brew.sh/formula/gum
	hugo             # https://formulae.brew.sh/formula/hugo
	imagemagick      # https://formulae.brew.sh/formula/imagemagick
	ipython          # https://formulae.brew.sh/formula/ipython
	jnv              # https://formulae.brew.sh/formula/jnv
	jq               # https://formulae.brew.sh/formula/jq
	just             # https://formulae.brew.sh/formula/just
	lazydocker       # https://formulae.brew.sh/formula/lazydocker
	lazygit          # https://formulae.brew.sh/formula/lazygit
	lazysql          # https://formulae.brew.sh/formula/lazysql
	less             # https://formulae.brew.sh/formula/less
	lsd              # https://formulae.brew.sh/formula/lsd
	mailpit          # https://formulae.brew.sh/formula/mailpit
	neovim           # https://formulae.brew.sh/formula/neovim
	netcat           # https://formulae.brew.sh/formula/netcat
	nmap             # https://formulae.brew.sh/formula/nmap
	node             # https://formulae.brew.sh/formula/node
	peco             # https://formulae.brew.sh/formula/peco
	poppler          # https://formulae.brew.sh/formula/poppler
	pre-commit       # https://formulae.brew.sh/formula/pre-commit
	resvg            # https://formulae.brew.sh/formula/resvg
	rip2             # https://formulae.brew.sh/formula/rip2
	ripgrep          # https://formulae.brew.sh/formula/ripgrep
	rustup           # https://formulae.brew.sh/formula/rustup
	silicon          # https://formulae.brew.sh/formula/silicon
	source-highlight # https://formulae.brew.sh/formula/source-highlight
	starship         # https://formulae.brew.sh/formula/starship
	stow             # https://formulae.brew.sh/formula/stow
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
casks_dev=(
	balenaetcher       # https://formulae.brew.sh/cask/balenaetcher
	cyberduck          # https://formulae.brew.sh/cask/cyberduck
	fork               # https://formulae.brew.sh/cask/fork
	keymapp            # https://formulae.brew.sh/cask/keymapp
	visual-studio-code # https://formulae.brew.sh/cask/visual-studio-code
)

brew_devops=(
	awscli   # https://formulae.brew.sh/formula/awscli
	flyctl   # https://formulae.brew.sh/formula/flyctl
	k9s      # https://formulae.brew.sh/formula/k9s
	opentofu # https://formulae.brew.sh/formula/opentofu
)
casks_devops=(
	# docker   # https://formulae.brew.sh/cask/docker
	orbstack # https://formulae.brew.sh/cask/orbstack
)

brew_databases=(
	libsql   # https://formulae.brew.sh/formula/libsql
	pgvector # https://formulae.brew.sh/formula/pgvector
	postgis  # https://formulae.brew.sh/formula/postgis
	valkey   # https://formulae.brew.sh/formula/valkey
)
casks_databases=(
	beekeeper-studio    # https://formulae.brew.sh/cask/beekeeper-studio
	dbeaver-community   # https://formulae.brew.sh/cask/dbeaver-community
	postgres-unofficial # https://formulae.brew.sh/cask/postgres-unofficial
	postico             # https://formulae.brew.sh/cask/postico
	tableplus           # https://formulae.brew.sh/cask/tableplus
)

casks_media=(
	audacity # https://formulae.brew.sh/cask/audacity
	gimp     # https://formulae.brew.sh/cask/gimp
	inkscape # https://formulae.brew.sh/cask/inkscape
	spotify  # https://formulae.brew.sh/cask/spotify
	vlc      # https://formulae.brew.sh/cask/vlc
)

casks_fonts=(
	font-cascadia-code          # https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-cascadia-code.rb
	font-commit-mono            # https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-commit-mono.rb
	font-iosevka                # https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-iosevka.rb
	font-lilex                  # https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-lilex.rb
	font-symbols-only-nerd-font # https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-symbols-only-nerd-font.rb
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
	"${brew_dev[@]}"
	"${brew_devops[@]}"
	"${brew_databases[@]}"
)
casks=(
	"${casks_general[@]}"
	"${casks_dev[@]}"
	"${casks_devops[@]}"
	"${casks_databases[@]}"
	"${casks_media[@]}"
	"${casks_fonts[@]}"
)
# gophers=()
# crates=()

# Install packages
info "Let's get to the hard stuff"
brew install --formula "${formulae[@]}"
brew install --cask "${casks[@]}"
mas install "${app_store_apps[@]}"
# go install "${gophers[@]}"
# cargo install "${crates[@]}"

# Additional commands for installations, because macOS (fucking Apple fucks)
if xattr '/Applications/Zen Browser.app/' | grep -q 'com.apple.quarantine'; then
	warning "Let Zen be zen (fucking Apple fucks)"
	xattr -d com.apple.quarantine '/Applications/Zen Browser.app/'
fi

# Adding `opentofu` to PATH as drop-in replacement for `terraform`
if [ "$(readlink /usr/local/bin/terraform 2>/dev/null)" != "$(which tofu)" ]; then
	sudo ln -sf "$(which tofu)" /usr/local/bin/terraform
fi

# Make sure macOS runtime and bin dirs exist
if [ ! -d "$XDG_BIN_HOME" ]; then
	info "Creating XDG_BIN_HOME directory"
	mkdir -p "$XDG_BIN_HOME"
fi

source "$HOME/.dotfiles/scripts/common.sh"

success "Cleaning Up"
brew cleanup

runtime=$((($(date +%s) - start) / 60))
success "Total Setup Time $runtime Minutes"
