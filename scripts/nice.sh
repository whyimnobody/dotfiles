#!/usr/bin/env bash

# sddm looking spicy
sudo pacman -S --needed --noconfirm qt6-svg qt6-virtualkeyboard qt6-multimedia=ffmpeg

# Hyprland, hyprpaper, hyprpm
sudo pacman -S --needed --noconfirm cmake cpio
hyprpm add https://github.com/hyprwm/hyprland-plugins
hyprpm enable hyprexpo
hyprpm add https://github.com/KZDKM/Hyprspace
hyprpm enable Hyprspace

# Wallpapers
git -C "$HOME/.dotfiles" submobule update --init --recursive wallpapers
mkdir -p ~/pictures/wallpapers
rsync -av --exclude=".*" ~/.dotfiles/wallpapers/ ~/pictures/wallpapers/

# Waybar
sudo pacman -S --needed --noconfirm waybar

# AGS
yay -S --needed --noconfirm --answerclean NotInstalled --answerdiff None aylurs-gtk-shell-git

# sddm looking spicy
sudo pacman -S --needed --noconfirm sddm qt6-svg qt6-virtualkeyboard qt6-multimedia-ffmpeg
sudo rsync -a --delete --relative ../rice/./etc/sddm.conf.d/ ../rice/./usr/share/sddm/themes/sakura/ /
