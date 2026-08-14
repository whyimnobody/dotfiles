#!/usr/bin/env bash

set -euo pipefail

repo_dir="$HOME/dotfiles"
repo_url=git@github.com:whyimnobody/dotfiles.git

if [[ ! -d "$repo_dir/.git" ]]; then
	if [[ -e "$repo_dir" ]]; then
		printf 'Cannot clone dotfiles: %s exists and is not a Git repository\n' "$repo_dir" >&2
		exit 1
	fi
	git clone --filter=blob:none --sparse "$repo_url" "$repo_dir"
fi

existing_url="$(git -C "$repo_dir" remote get-url origin)"
if [[ "$existing_url" != "$repo_url" ]]; then
	printf 'Refusing to modify %s: origin is %s, expected %s\n' \
		"$repo_dir" "$existing_url" "$repo_url" >&2
	exit 1
fi

git -C "$repo_dir" sparse-checkout init --no-cone
git -C "$repo_dir" sparse-checkout set \
	terminal/.config/bat \
	terminal/.config/btop \
	terminal/.config/fzf \
	terminal/.config/nvim \
	terminal/.config/starship \
	tmux \
	zsh

stow --dir="$repo_dir" --target="$HOME" terminal tmux zsh
