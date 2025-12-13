#!/usr/bin/env bash

# Hyprland, hyprpaper, hyprpm
sudo pacman -S --needed --noconfirm cmake cpio
hyprpm add https://github.com/hyprwm/hyprland-plugins
hyprpm enable hyprexpo
hyprpm add https://github.com/KZDKM/Hyprspace
hyprpm enable Hyprspace

# hyprcursor theme
yay -S --needed --noconfirm --answerclean NotInstalled --answerdiff None nordzy-hyprcursors

# Wallpapers
git -C "$HOME/.dotfiles" submobule update --init --recursive wallpapers
# mkdir -p ~/pictures/wallpapers
# rsync -av --exclude=".*" ~/.dotfiles/wallpapers/ ~/pictures/wallpapers/

# Waybar
sudo pacman -S --needed --noconfirm waybar

# sddm looking spicy
sudo pacman -S --needed --noconfirm sddm qt6-svg qt6-virtualkeyboard qt6-multimedia-ffmpeg
sudo rsync -a --delete --relative ../rice/./etc/sddm.conf.d/ ../rice/./usr/share/sddm/themes/sakura/ /
