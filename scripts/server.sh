git clone --filter=blob:none --sparse git@github.com:you/dotfiles.git ~/dotfiles
cd ~/dotfiles

git sparse-checkout init --no-cone

git sparse-checkout set terminal/.config/bat terminal/.config/btop terminal/.config/fzf terminal/.config/nvim terminal/.config/starship tmux zsh

stow terminal tmux zsh
