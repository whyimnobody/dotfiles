#!/usr/bin/env bash

set -euo pipefail

info() {
	printf '\033[1;34m==>\033[0m %s\n' "$*"
}

die() {
	printf '\033[1;31merror:\033[0m %s\n' "$*" >&2
	exit 1
}

install_arch() {
	command -v pacman >/dev/null 2>&1 || die "pacman was not found"

	local packages=(
		# C and C++
		base-devel
		clang
		cmake
		gdb
		lldb
		ninja

		# Numerical computing
		octave

		# Minimal, practical LaTeX
		biber
		texlive-basic
		texlive-binextra
		texlive-latex
		texlive-latexextra
		texlive-latexrecommended

		# Typst and its language server
		tinymist
		typst
	)

	info "Installing school tooling with pacman"
	sudo pacman -Syu --needed --noconfirm "${packages[@]}"
}

install_macos() {
	command -v brew >/dev/null 2>&1 || die "Homebrew is required; run scripts/mac.sh first"
	command -v xcrun >/dev/null 2>&1 || die "Xcode Command Line Tools are required; run: xcode-select --install"
	xcrun --find clang >/dev/null 2>&1 || die "clang is unavailable; run: xcode-select --install"

	local formulae=(
		# C and C++ (clang and lldb come from Xcode Command Line Tools)
		cmake
		ninja

		# Numerical computing
		octave

		# Typst and its language server
		tinymist
		typst
	)

	info "Installing school tooling with Homebrew"
	brew install "${formulae[@]}"

	if ! brew list --cask basictex >/dev/null 2>&1; then
		info "Installing the compact BasicTeX distribution"
		brew install --cask basictex
	fi

	local tlmgr=/Library/TeX/texbin/tlmgr
	[[ -x "$tlmgr" ]] || die "BasicTeX was installed, but $tlmgr is unavailable; restart the terminal and rerun this script"

	info "Installing common LaTeX packages and bibliography/build tools"
	sudo "$tlmgr" update --self
	sudo "$tlmgr" install \
		biber \
		collection-latexextra \
		collection-latexrecommended \
		latexmk
}

case "$(uname -s)" in
	Darwin)
		install_macos
		;;
	Linux)
		[[ -r /etc/arch-release ]] || die "Linux support is currently limited to Arch Linux"
		install_arch
		;;
	*)
		die "Unsupported operating system: $(uname -s)"
		;;
esac

info "School tooling is ready"
