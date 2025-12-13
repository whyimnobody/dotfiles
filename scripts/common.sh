# Install TPM
if [ ! -d "$HOME/.local/share/tmux/plugins/tpm/" ]; then
	info "Install tmux and plugins"
	(
		TPM_DIR=~/.local/share/tmux/plugins/tpm
		TPM_COMMIT="99469c4a9b1ccf77fade25842dc7bafbc8ce9946"
		git clone "https://github.com/tmux-plugins/tpm" "$TPM_DIR"
		cd "$TPM_DIR" && git checkout "$TPM_COMMIT"
		stow --dir="$HOME"/.dotfiles --target="$HOME" --no-folding tmux
		"$TPM_DIR"/scripts/install_plugins.sh
	)
fi

# Install tmux-sessionizer
if [ ! -f "$XDG_BIN_HOME/tmux-sessionizer" ]; then
	info "Grabbing tmux-sessionizer"
	curl -fsSL "https://raw.githubusercontent.com/ThePrimeagen/tmux-sessionizer/fa17fa10a47db3a5a3e4f22f1b7eea618691b058/tmux-sessionizer" -o "$XDG_BIN_HOME/tmux-sessionizer"
	chmod +x "$XDG_BIN_HOME/tmux-sessionizer"
fi

# Sort out stowed packages
info "Stowing packages"
stow --dir="$HOME"/.dotfiles --target="$HOME" --no-folding git terminal tmux zsh

# Set zsh as the default shell
if [[ "$SHELL" != "$(command -v zsh)" ]]; then
	info "Changing shell to zsh"
	chsh -s "$(command -v zsh)"
fi

# Setup rust toolchain
rustup default stable
