#!/usr/bin/env bash

set -euo pipefail

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
	yay_build_dir="$(mktemp -d)"
	trap 'rm -rf -- "$yay_build_dir"' EXIT
	git clone https://aur.archlinux.org/yay.git "$yay_build_dir"
	(
		cd "$yay_build_dir"
		makepkg -si
	)
	rm -rf -- "$yay_build_dir"
	trap - EXIT
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
	ansible
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
	jupyterlab
	jnv
	jq
	just
	lazygit
	less
	lsd
	man-db
	neovim
	nmap
	nodejs
	npm
	octave
	opencode
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
	docker
	docker-compose
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
	grim
	hypridle
	hyprlock
	hyprpaper
	hyprpicker
	kanshi
	liquidctl
	openrgb
	rofi-wayland
	satty
	slurp
	tailscale
	waybar
	wf-recorder
	wl-clipboard
)

system_aur=(
	clipse
	wlogout
)

packages=(
	"${general[@]}"
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
	openrgb-dram.service
	jupyter-lab.service
)
system_services=(
	docker.service
	tailscaled.service
)

info "The actual package installs now"
sudo pacman -Syu --needed --noconfirm "${packages[@]}"
yay -S --needed --noconfirm --answerclean NotInstalled --answerdiff None "${aura[@]}"
go install "${go[@]}"

info "Configure Caddy"
"$HOME/.dotfiles/scripts/caddy.sh"

info "Configure the nice desktop package"
"$HOME/.dotfiles/scripts/nice.sh"
stow --dir="$HOME/.dotfiles" --target="$HOME" nice

info "Enable boot-time user services"
sudo loginctl enable-linger "$(id -un)"
sudo gpasswd -a "$(id -un)" i2c

info "Enable and start user services"
systemctl --user enable --now "${user_services[@]}"

info "Enable and start system services"
sudo systemctl enable --now "${system_services[@]}"

# Some housekeeping
source "$HOME/.dotfiles/scripts/common.sh"

# TODO: Sort out GPG on system
# TODO: Figure out a Maccy like experience
# TODO: Sort out bluetooth devices (keeb & mouse)
# TODO: Sort out mic
