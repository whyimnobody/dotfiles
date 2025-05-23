# ANDROID
# export ANDROID_HOME="$HOME/dev/android/sdk"
# export MANPATH="/usr/local/man:$MANPATH"
# export PATH="$PATH:$ANDROID_HOME/tools"
# export PATH="$PATH:$ANDROID_HOME/platform-tools"

# ANSIBLE
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"

# DIRENV
eval "$(direnv hook zsh)"

# ELIXIR
export MIX_XDG=1 # https://hexdocs.pm/hex/Mix.Tasks.Hex.Config.html

# FLY
export FLY_CONFIG_DIR="$XDG_CONFIG_HOME/fly"

# FZF
# [ -f ${XDG_CONFIG_HOME}/fzf/fzf.zsh ] && source ${XDG_CONFIG_HOME}/fzf/fzf.zsh
source <(fzf --zsh)

# GOLANG
export GOPATH="$HOME/dev/go"
case "$(uname -s)" in
  Darwin)
    export GOROOT="$(brew --prefix golang)/libexec"
    ;;
  # Linux)
  #   export GOROOT="/usr/lib/go"
  #   ;;
esac
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$(go env GOPATH)/bin"

case "$(uname -s)" in
  Darwin)
    # GNUSED
    export PATH="$(brew --prefix gsed)/libexec/gnubin:$PATH"
  ;;
esac

# LAZYGIT
export LG_CONFIG_FILE="$XDG_CONFIG_HOME/lazygit/config.yml,$XDG_CONFIG_HOME/lazygit/themes/mocha/teal.yml"

# LESS
# Add syntax highlighting to less
export LESSOPEN="| bat --paging=never --color=always %s"

# POSTGRES
case "$(uname -s)" in
  Darwin)
    export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"
  ;;
esac

# STARSHIP
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
eval "$(starship init zsh)"

# STOW
export STOW_DIR="$HOME/.dotfiles"

# # THEFUCK
# eval $(thefuck --alias)

# TMUX
export ZSH_TMUX_CONFIG="$XDG_CONFIG_HOME/tmux/tmux.conf"  # For the zplug plugin
# tmux attach -t completion
_tmux_attach_completion() {
  # Check if the current command is 'tmux attach'
  if [[ "$words[1]" == "tmux" && "$words[2]" == "attach" ]]; then
    # Define the expected options and arguments
    _arguments \
      '-t+[Specify tmux session]:session name:(_tmux_list_sessions)' \
      '*: :_files'
  else
    # Fallback to default completion
    _arguments '*:filename:_files'
  fi
}
# Helper function to list tmux sessions
_tmux_list_sessions() {
  local -a sessions
  # Fetch the list of tmux sessions, handling cases with no sessions
  sessions=("${(@f)$(tmux list-sessions -F '#S' 2>/dev/null)}")
  if (( ${#sessions} )); then
    _describe 'tmux session' sessions
  else
    _message 'No active tmux sessions'
  fi
}
# Associate the completion function with 'tmux attach'
compdef _tmux_attach_completion tmux


# ZOXIDE
eval "$(zoxide init zsh)"

