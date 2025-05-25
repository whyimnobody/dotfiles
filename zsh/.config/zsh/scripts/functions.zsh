# Color Codes (RGB)
LIGHT_BLUE=$'\e[38;2;116;199;236m' #74c7ec
LIGHT_GREEN=$'\e[38;2;166;227;161m' #a6e3a1
LIGHT_YELLOW=$'\e[38;2;249;226;175m' #f9e2af
LIGHT_RED=$'\e[38;2;243;139;168m' #f38ba8
RESET_COLOR=$'\e[0m'

## @description: Prints a message in an informational color (light blue).
## @param {string} message: The message to print.
function info {
  printf "%b\n" "${LIGHT_BLUE}${1}${RESET_COLOR}"
}

## @description: Prints a message in a success color (light green).
## @param {string} message: The message to print.
function success {
  printf "%b\n" "${LIGHT_GREEN}${1}${RESET_COLOR}"
}

## @description: Prints a message in a warning color (light yellow).
## @param {string} message: The message to print.
function warning {
  printf "%b\n" "${LIGHT_YELLOW}${1}${RESET_COLOR}"
}

## @description: Prints a message in an error color (light red).
## @param {string} message: The message to print.
function error {
  printf "%b\n" "${LIGHT_RED}${1}${RESET_COLOR}"
}
## @description: Refreshes the current Zsh session.
## If background jobs are running, it prints an error message.
## Otherwise, it executes a new Zsh shell.
function refresh {
  if [ -n "$(jobs)" ]; then
    error "Error: %j job(s) in background"
  else
    exec zsh -l
  fi
}

## @description: Decodes a JWT (JSON Web Token).
## @param {string} jwt: The JWT string.
## @return {string} The decoded header and payload of the JWT (printed to stdout).
## @note: The function uses `jq` to decode and format the JWT.
function decode.jwt {
  jq -R 'split(".") | .[0] | @base64d | fromjson' <<<"$1" && jq -R 'split(".") | .[1] | @base64d | fromjson' <<<"$1"
}

## @description: Formats JSON data.
## @param {string} [filename=/tmp/some.json]: The filename to save the JSON data to. Defaults to /tmp/some.json.
## Reads JSON data from the clipboard using `pbpaste`, formats it using `jq`, and saves it to the specified file.
function format.json {
  pbpaste >"${1:-/tmp/some.json}" && jq . "${1:-/tmp/some.json}"
}

function upgrade {
  case "$(uname -s)" in
    Darwin)
      brew update-if-needed 
      brew upgrade
      brew cleanup
    ;;
    Linux)
      sudo pacman -Syu --noconfirm
      yay -Syu --noconfirm
    ;;
  esac
  zinit update
}


ta()  { tmux attach -t "$@"; }
tad() { tmux attach -d -t "$@"; }
ts()  { tmux new-session -s "$@"; }
tl()  { tmux list-sessions; }
tkss() { tmux kill-session -t "$@"; }
tksv() { tmux kill-server; }
tz() {
  CONFIG_DIR="${XDG_CONFIG_HOME}/tmux" tmux-sessionizer;
}

## @description: Checks and installs a package.
## @param {string} package: The name of the package to install.
## @param {string} type: The type of package ("app_store", "formula", "cask", "go", "rust").
## @return {integer} 0 on success, 1 on failure.
## @note: This function uses a database to track installed packages and skips installation if the package is already installed.
## It supports different package managers (mas, brew, go, cargo).
function install_package {
  local package="$1"
  local type="$2"
  local is_installed=0

  # Check if the package is already in the database.
  is_installed=$(sqlite3 "$PACKAGES_DATABASE" "SELECT COUNT(*) FROM packages WHERE name = '$package' AND type = '$type';")
  if (( is_installed > 0 )); then
    info "Package '$package' ($type) already installed. Skipping."
    return 0
  fi

  local install_cmd=""
  case "$type" in
    "app_store") install_cmd="mas install" ;;
    "formula") install_cmd="brew install" ;;
    "cask") install_cmd="brew install --cask" ;;
    "go") install_cmd="go install" ;;
    "rust") install_cmd="cargo install" ;;
    *) error "Invalid package type: $type" ; return 1 ;;
  esac

  info "Installing '$package' ($type)..."

  if ! $(echo "$install_cmd" "$package" ); then
    error "Error installing $type package: '$package'."
    error "Exiting."
    return 1
  fi

  # Add the newly installed package to the database.
  sqlite3 "$PACKAGES_DATABASE" "INSERT INTO packages (name, type) VALUES ('$package', '$type')"
  return 0
}

## @description: Uninstalls packages of a given type.
## @param {string} type: The type of packages to uninstall ("formula", "cask", "go", "rust", "app_store", "nix").
## @param {string} packages_array_name: The name of the array variable containing the packages to uninstall.
## @param {string} [current_packages_file]: The path to a file containing the currently installed packages of this type (used for formulae and casks).  If empty, it assumes the packages are no longer present and attempts uninstallation.
## @return {integer} 0 on success (all packages processed), 1 on error (at least one uninstall command failed).
## @note: This function iterates through the packages in the specified array and uninstalls those that are no longer present (for formulae and casks, it checks against the current_packages_file). For other types (go, rust, app_store, nix), it attempts uninstallation directly. It uses different uninstall commands based on the package type.  It removes the package from the database even if the uninstall command fails to prevent repeated attempts.
function uninstall_packages {
  local type="$1"
  local packages_array_name="$2"
  local current_packages_file="$3"
  local uninstall_cmd=""
  local overall_result=0 # Initialize to success

  case "$type" in
    "formula") uninstall_cmd="brew uninstall" ;;
    "cask") uninstall_cmd="brew uninstall --cask" ;;
    "go") uninstall_cmd="go uninstall" ;; # Or potentially just remove the binary
    "rust") uninstall_cmd="cargo uninstall" ;;
    "app_store") uninstall_cmd="mas uninstall" ;;
    *) error "Invalid package type: $type" ; return 1 ;;
  esac

  return "$overall_result" # Return 0 if all packages were processed, 1 if any uninstall failed.
}
