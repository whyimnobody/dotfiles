#!/usr/bin/env bash

# Get the dotfiles
if [ ! -d "$HOME/.dotfiles/" ]; then
	git clone "https://github.com/whyimnobody/dotfiles" ~/.dotfiles
fi

# Import my functions, including the install_package function and coloured stdout functions
source "$HOME/.dotfiles/zsh/.config/zsh/scripts/functions.zsh"
source "$HOME/.dotfiles/zsh/.zshenv"

info "Install the things we need first, because yikes"
sudo pacman -S --noconfirm --needed git

# Install yay
if ! command -v yay &>/dev/null; then
	info "Installing yay"
	git clone https://aur.archlinux.org/yay.git /tmp/yay && cd /tmp/yay/ && makepkg -si
fi

# Packages
general=(
	obsidian
	syncthing
)
general_aur=(
	1password
	brave-bin
	dragon-drop
	gallery-dl
	librewolf-bin
	mullvad-vpn
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
	asciinema
	bat
	bottom
	croc
	ctop
	dbeaver
	# devbox
	diff-so-fancy
	direnv
	elixir
	entr
	fd
	ffmpeg
	fzf
	ghostty
	git-delta
	git-lfs
	glow
	gnu-netcat
	go
	gum
	hugo
	imagemagick
	ipython
	jnv
	jq
	just
	lazygit
	less
	lsd
	man-db
	mailpit
	neovim
	nmap
	nodejs
	npm
	octave
	pastel
	peco
	poppler
	pre-commit
	ripgrep
	rsync
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
	claude-code
	cursor-cli
	lazydocker
	lazysql
	mailpit
	openai-codex-bin
	opencode-bin
	python-commitizen
	resvg
	rip2-bin
	rr
	tlrc
)
dev_go=(
	github.com/control-theory/gonzo/cmd/gonzo@latest
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
	ttf-cascadia-code
	ttc-iosevka
	ttf-lilex-nerd
	ttf-nerd-fonts-symbols
	ttf-space-mono-nerd
)

system=(
	bluez
	bluez-utils
	caddy
	flameshot
	hyprlock
	hyprpaper
	hyprpicker
	rofi-wayland
	waybar
	wf-recorder
	wl-clipboard
)

system_aur=(
	wlogout
)

packages=(
	"${general[@]}"
	"${fonts[@]}"
	"${media[@]}"
	"${dev[@]}"
	"${devops[@]}"
	"${databases[@]}"
	"${fonts[@]}"
	"${system[@]}"
)
aura=(
	"${general_aur[@]}"
	"${dev_aur[@]}"
	"${devops_aur[@]}"
	"${databases_aur[@]}"
	"${system_aur[@]}"
)
go=(
	"${dev_go[@]}"
)
user_services=(
	syncthing.service
)

info "The actual package installs now"
sudo pacman -Syu --needed --noconfirm "${packages[@]}"
yay -S --needed --noconfirm --answerclean NotInstalled --answerdiff None "${aura[@]}"
go install "${go[@]}"

info "Configure Caddy"
"$HOME/.dotfiles/scripts/caddy.sh"

info "Enable and start user services"
systemctl --user enable --now "${user_services[@]}"

# Some housekeeping
source "$HOME/.dotfiles/scripts/common.sh"

# TODO: Sort out GPG on system
# TODO: Figure out a Maccy like experience
# TODO: Sort out bluetooth devices (keeb & mouse)
# TODO: Sort out mic
