# DIRENV
autoload -Uz add-zsh-hook

# https://github.com/rothgar/mastering-zsh/blob/master/docs/config/hooks.md
_direnv_on_exit() {
  local prev="$OLDPWD" new="$PWD"
  if [[ -f "$prev/.envrc" && -f "$prev/devbox.json" ]]; then
    # echo "Zsh: left a devbox dir, running exit command…"
    exit
  fi
}

add-zsh-hook chpwd _direnv_on_exit
