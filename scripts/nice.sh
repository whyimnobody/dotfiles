#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

ensure_hyprpm_repo() {
	local url="$1"
	local name="$2"

	if ! hyprpm list | grep -Fq "Repository $name:"; then
		hyprpm add "$url"
	fi
}

ensure_hyprpm_plugin() {
	local name="$1"

	if ! hyprpm list | grep -A 1 -F "Plugin $name" | grep -q "enabled: true"; then
		hyprpm enable "$name"
	fi
}

# Hyprland, hyprpaper, hyprpm
sudo pacman -S --needed --noconfirm \
	cmake \
	cpio \
	qt6-multimedia-ffmpeg \
	qt6-svg \
	qt6-virtualkeyboard \
	sddm \
	waybar

ensure_hyprpm_repo https://github.com/hyprwm/hyprland-plugins hyprland-plugins
ensure_hyprpm_plugin hyprexpo
ensure_hyprpm_repo https://github.com/KZDKM/Hyprspace Hyprspace
ensure_hyprpm_plugin Hyprspace

# Wallpapers
git -C "$repo_root" submodule update --init --recursive wallpapers
mkdir -p "$HOME/pictures/wallpapers"
rsync -av --exclude=".*" "$repo_root/wallpapers/" "$HOME/pictures/wallpapers/"

# AGS
yay -S --needed --noconfirm --answerclean NotInstalled --answerdiff None aylurs-gtk-shell-git

# sddm looking spicy
rice_root="$repo_root/../rice"
if [[ -d "$rice_root/etc/sddm.conf.d" && -d "$rice_root/usr/share/sddm/themes/sakura" ]]; then
	sudo rsync -a --delete --relative \
		"$rice_root/./etc/sddm.conf.d/" \
		"$rice_root/./usr/share/sddm/themes/sakura/" \
		/
else
	printf 'Skipping SDDM theme: %s is unavailable\n' "$rice_root" >&2
fi

# Keep the SDDM system configuration versioned with the nice desktop package.
sudo install -Dm644 "$repo_root/nice/.config/sddm/theme.conf" \
	/etc/sddm.conf.d/theme.conf
sudo install -Dm644 "$repo_root/nice/.config/sddm/virtualkbd.conf" \
	/etc/sddm.conf.d/virtualkbd.conf

# Apply the LCD orientation at boot. The Kraken does not reliably retain this
# setting across power cycles, so keep the service source in the dotfiles.
sudo install -Dm644 "$repo_root/nice/.config/systemd/system/kraken-lcd.service" \
	/etc/systemd/system/kraken-lcd.service
sudo systemctl daemon-reload
sudo systemctl enable --now kraken-lcd.service
