#!/usr/bin/env bash

# Install the things we need first, because yikes
sudo pacman -S --noconfirm --needed git

# Get the dotfiles
if [ ! -d "$HOME/.dotfiles/" ]; then
	git clone "https://github.com/whyimnobody/dotfiles" ~/.dotfiles
fi

# Install yay
if ! command -v yay &>/dev/null; then
	git clone https://aur.archlinux.org/yay.git /tmp/yay && cd /tmp/yay/ && makepkg -si
fi

# Packages
general=(
	dragon-drop
	obsidian
	syncthing
)
general_aur=(
	1password
	brave-bin
	gallery-dl
	librewolf-bin
	signal-desktop
	wireguard-tools
	yt-dlp-git
	zen-browser-bin
)

media=(
	audacity
	gimp
	inkscape
	vlc
)

dev=(
	act
	age
	bat
	bottom
	croc
	ctop
	dbeaver
	devbox
	diff-so-fancy
	direnv
	elixir
	fd
	ffmpeg
	fzf
	ghostty
	git-delta
	git-lfs
	glow
	gnu-netcat
	go
	hugo
	imagemagick
	ipython
	jq
	just
	lazygit
	less
	lsd
	man-db
	neovim
	nmap
	nodejs
	peco
	poppler
	pre-commit
	resvg
	ripgrep
	rustup
	silicon
	source-highlight
	starship
	stow
	tmux
	tree
	uv
	words
	yazi
	yq
	zoxide
	zsh
)
dev_aur=(
	beekeeper-studio
	lazydocker
	lazysql
	python-commitizen
	rm-improved
	tlrc
)

devops=(
	aws-cli
	k9s
)
devops_aur=(
	flyctl
	opentofu-bin
)

databases=(
	postgis
	valkey
)
databases_aur=(
	libsql
	pgvector
)

fonts=(
	otf-commit-mono-nerd
	ttf-cascadia-code-nerd
	ttf-iosevka-nerd
	ttf-lilex-nerd
	ttf-space-mono-nerd
)

packages=(
	"${general[@]}"
	"${fonts[@]}"
	"${media[@]}"
	"${dev[@]}"
	"${devops[@]}"
	"${databases[@]}"
)
aura=(
	"${general_aur[@]}"
	"${dev_aur[@]}"
	"${devops_aur[@]}"
	"${databases_aur[@]}"
)

sudo pacman -Syu --needed --noconfirm "${packages[@]}"
yay -Syu --needed "${aura[@]}"

source "$HOME/.dotfiles/scripts/common.sh"

# TODO: Sort out GPG on system
# TODO: Figure out a Maccy like experience
# TODO: Install wallpapers (hyprpaper?)
# TODO: Sort out bluetooth devices (keeb & mouse)
# TODO: Check speakers
# TODO: Make the login pretty
# TODO: Sort out the power and logout things
# TODO: Sort out mic
# TODO: Mount second drive
# TODO: Install waybar
# TODO: Install rofi
# TODO: Install Steam
# TODO: Proton
# TODO: some games
# TODO: Password managers
