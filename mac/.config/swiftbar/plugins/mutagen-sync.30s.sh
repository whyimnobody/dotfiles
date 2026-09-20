#!/usr/bin/env bash

# <xbar.title>Mutagen Screenshot Sync</xbar.title>
# <xbar.version>v1.0</xbar.version>
# <xbar.author>whyimnobody</xbar.author>
# <xbar.author.github>whyimnobody</xbar.author.github>
# <xbar.desc>Monitors the Mutagen screenshots session to Asura.</xbar.desc>
# <xbar.dependencies>bash,mutagen</xbar.dependencies>
# <swiftbar.refreshOnOpen>true</swiftbar.refreshOnOpen>

set -euo pipefail

export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

session="${MUTAGEN_SYNC_NAME:-screenshots}"
mutagen_bin="$(command -v mutagen || true)"
script="$0"

echo_menu_header() {
	local color="$1"
	echo ":arrow.triangle.2.circlepath: | symbolize=true color=$color"
	echo "---"
}

if [[ -z "$mutagen_bin" ]]; then
	echo_menu_header red
	echo "mutagen not found | color=red"
	exit 0
fi

if [[ $# -eq 1 ]]; then
	case "$1" in
		flush)
			"$mutagen_bin" sync flush "$session" >/dev/null
			;;
		resume)
			"$mutagen_bin" sync resume "$session" >/dev/null
			;;
		daemon-start)
			"$mutagen_bin" daemon start >/dev/null
			;;
	esac
	exit 0
fi

list_out=""
list_err=0
if ! list_out="$("$mutagen_bin" sync list "$session" 2>&1)"; then
	list_err=1
fi

if [[ "$list_err" -ne 0 ]]; then
	echo_menu_header red
	if printf '%s' "$list_out" | grep -qi 'unable to connect to daemon'; then
		echo "Mutagen daemon is not running | color=red"
		echo "Start daemon | bash='$script' param1=daemon-start terminal=false refresh=true"
	else
		echo "screenshots session missing | color=red"
		echo "--$(printf '%s' "$list_out" | tr '\n' ' ' | tr '|' ':') | trim=false"
	fi
	echo "Checked: $(date '+%H:%M:%S') | color=#8e8e93"
	echo "---"
	echo "Refresh | refresh=true"
	exit 0
fi

status="$(printf '%s\n' "$list_out" | sed -n 's/^Status:[[:space:]]*//p' | head -n 1)"
paused="$(printf '%s\n' "$list_out" | sed -n 's/^[[:space:]]*Paused:[[:space:]]*//p' | head -n 1)"
alpha_connected="$(printf '%s\n' "$list_out" | awk '
	/^Alpha:/ { in_side=1; next }
	/^Beta:/ { in_side=0 }
	in_side && /Connected:/ {
		sub(/^[[:space:]]*Connected:[[:space:]]*/, "")
		print
		exit
	}
')"
beta_connected="$(printf '%s\n' "$list_out" | awk '
	/^Beta:/ { in_side=1; next }
	/^Status:/ { in_side=0 }
	in_side && /Connected:/ {
		sub(/^[[:space:]]*Connected:[[:space:]]*/, "")
		print
		exit
	}
')"

color="#30d158"
label="${status:-Unknown}"

if [[ "$paused" == "Yes" ]]; then
	color="#ffd60a"
	label="Paused"
elif [[ "$beta_connected" != "Yes" || "$alpha_connected" != "Yes" ]]; then
	color="#ffd60a"
	label="${status:-Disconnected}"
else
	case "$status" in
		"Watching for changes")
			color="#30d158"
			label="Watching"
			;;
		Scanning* | Connecting* | Staging* | Waiting* | Reconciling* | Saving*)
			color="#ffd60a"
			label="$status"
			;;
		Halted* | "" )
			color="#ff453a"
			label="${status:-Unknown}"
			;;
		*)
			color="#ffd60a"
			label="$status"
			;;
	esac
fi

echo_menu_header "$color"
echo "Mutagen → $session: $label | color=$color"
echo "Alpha: ${alpha_connected:-unknown}"
echo "Beta: ${beta_connected:-unknown}"
echo "Checked: $(date '+%H:%M:%S') | color=#8e8e93"
echo "---"
echo "Flush | bash='$script' param1=flush terminal=false refresh=true"
if [[ "$paused" == "Yes" ]]; then
	echo "Resume | bash='$script' param1=resume terminal=false refresh=true"
fi
echo "List in Terminal | bash='$mutagen_bin' param1=sync param2=list param3='$session' terminal=true"
echo "Refresh | refresh=true"
