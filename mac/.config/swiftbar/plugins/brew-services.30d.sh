#!/usr/bin/env bash

# <xbar.title>Homebrew Services</xbar.title>
# <xbar.version>v2.0</xbar.version>
# <xbar.author>whyimnobody</xbar.author>
# <xbar.author.github>whyimnobody</xbar.author.github>
# <xbar.desc>Shows Homebrew user services and the system Caddy service.</xbar.desc>
# <xbar.dependencies>bash,brew,jq</xbar.dependencies>
# <swiftbar.refreshOnOpen>true</swiftbar.refreshOnOpen>

set -euo pipefail

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

BREW_BIN="${HOMEBREW_BREW_FILE:-$(command -v brew || true)}"
JQ_BIN="$(command -v jq || true)"
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/Library/Caches}/swiftbar"
ACTION_ERROR="$CACHE_DIR/brew-services-last-error"

valid_service() {
	case "$1" in
		*[!A-Za-z0-9@+._-]* | '') return 1 ;;
		*) return 0 ;;
	esac
}

safe_menu_text() {
	sed 's/|/:/g' | tr '\n' ' '
}

record_action() {
	local scope="$1"
	local action="$2"
	local service="$3"
	local output

	valid_service "$service" || return 64
	mkdir -p "$CACHE_DIR"

	if [[ "$scope" == system ]]; then
		if output="$(sudo env HOMEBREW_NO_AUTO_UPDATE=1 "$BREW_BIN" services "$action" "$service" 2>&1)"; then
			rm -f "$ACTION_ERROR"
		else
			printf '%s\n' "$output" >"$ACTION_ERROR"
			printf '%s\n' "$output" >&2
			return 1
		fi
	elif output="$(HOMEBREW_NO_AUTO_UPDATE=1 env -u TMUX "$BREW_BIN" services "$action" "$service" 2>&1)"; then
		rm -f "$ACTION_ERROR"
	else
		printf '%s\n' "$output" >"$ACTION_ERROR"
		return 1
	fi
}

if [[ $# -eq 3 ]]; then
	scope="$1"
	action="$2"
	service="$3"

	case "$scope:$action" in
		user:start | user:stop | user:restart | system:start | system:stop | system:restart)
			record_action "$scope" "$action" "$service"
			;;
	esac
	exit 0
fi

echo ":gearshape.fill: | symbolize=true emojize=false"
echo "---"

if [[ -z "$BREW_BIN" ]]; then
	echo "Homebrew not found | color=red"
	exit 0
fi
if [[ -z "$JQ_BIN" ]]; then
	echo "jq not found | color=red"
	exit 0
fi

if [[ -s "$ACTION_ERROR" ]]; then
	action_error="$(safe_menu_text <"$ACTION_ERROR")"
	echo "Last action failed | color=red"
	echo "--$action_error | trim=false"
	echo "---"
fi

if ! list_json="$(HOMEBREW_NO_AUTO_UPDATE=1 env -u TMUX "$BREW_BIN" services list --json 2>&1)"; then
	echo "Homebrew services unavailable | color=red"
	echo "--$(printf '%s' "$list_json" | safe_menu_text) | trim=false"
	exit 0
fi

if ! service_rows="$(printf '%s' "$list_json" | "$JQ_BIN" -r '
  .[] |
  [
    (.name // "unknown"),
    (.status // "unknown"),
    (.user // ""),
    (.file // .plist // ""),
    ((.exit_code // "") | tostring)
  ] | join("\u001f")
' | sort)"; then
	echo "Invalid Homebrew service data | color=red"
	exit 0
fi

echo "User services | color=#8e8e93"
if [[ -z "$service_rows" ]]; then
	echo "--None"
else
	while IFS=$'\x1f' read -r name status owner file exit_code; do
		[[ -n "$name" ]] || continue

		scope=user
		marker="⚪️"
		case "$status" in
			started) marker="🟢" ;;
			error) marker="🔴" ;;
			none | stopped) marker="⚪️" ;;
			*) marker="🟡" ;;
		esac

		if [[ "$owner" == root || "$file" == /Library/LaunchDaemons/* ]]; then
			scope=system
		fi

		detail="$status"
		[[ -n "$owner" ]] && detail="$detail · $owner"
		[[ -n "$exit_code" && "$exit_code" != 0 ]] && detail="$detail · exit $exit_code"
		echo "--$marker  $name | trim=false"
		echo "----$detail | color=#8e8e93"

		terminal=false
		[[ "$scope" == system ]] && terminal=true
		if [[ "$status" == started ]]; then
			echo "----Restart | bash='$0' param1='$scope' param2=restart param3='$name' terminal=$terminal refresh=true"
			echo "----Stop | bash='$0' param1='$scope' param2=stop param3='$name' terminal=$terminal refresh=true"
		elif [[ "$status" == error ]]; then
			echo "----Restart | bash='$0' param1='$scope' param2=restart param3='$name' terminal=$terminal refresh=true"
		else
			echo "----Start | bash='$0' param1='$scope' param2=start param3='$name' terminal=$terminal refresh=true"
		fi
	done <<<"$service_rows"
fi

# Caddy is deliberately installed as a root LaunchDaemon so it can bind ports
# 80/443. The user-scoped Homebrew query may omit it, so inspect launchd too.
if ! printf '%s\n' "$service_rows" | cut -d $'\x1f' -f1 | grep -qx caddy; then
	echo "System services | color=#8e8e93"
	if launchctl print system/homebrew.mxcl.caddy >/dev/null 2>&1; then
		echo "--🟢  caddy"
		echo "----started · root | color=#8e8e93"
		echo "----Restart | bash='$0' param1=system param2=restart param3=caddy terminal=true refresh=true"
		echo "----Stop | bash='$0' param1=system param2=stop param3=caddy terminal=true refresh=true"
	else
		echo "--⚪️  caddy"
		echo "----not loaded · root | color=#8e8e93"
		echo "----Start | bash='$0' param1=system param2=start param3=caddy terminal=true refresh=true"
	fi
fi

echo "---"
echo "Refresh | refresh=true"
