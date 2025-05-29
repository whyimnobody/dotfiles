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

# TODO: Fucking launcher first
# TODO: Then waybar
