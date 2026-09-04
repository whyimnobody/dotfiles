#!/usr/bin/env bash

# <xbar.title>1Password SSH Bridge</xbar.title>
# <xbar.version>v1.0</xbar.version>
# <xbar.author>whyimnobody</xbar.author>
# <xbar.author.github>whyimnobody</xbar.author.github>
# <xbar.desc>Monitors the supervised 1Password SSH agent bridge to Asura.</xbar.desc>
# <xbar.dependencies>bash,jq,1p-bridge</xbar.dependencies>
# <swiftbar.refreshOnOpen>true</swiftbar.refreshOnOpen>

set -euo pipefail

export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

host="${ONEPASSWORD_BRIDGE_HOST:-asura}"
bridge_bin="$(command -v 1p-bridge || true)"
jq_bin="$(command -v jq || true)"

if [[ -z "$bridge_bin" || -z "$jq_bin" ]]; then
	echo ":key.fill: | symbolize=true color=red"
	echo "---"
	[[ -n "$bridge_bin" ]] || echo "1p-bridge not found | color=red"
	[[ -n "$jq_bin" ]] || echo "jq not found | color=red"
	exit 0
fi

if ! status_json="$("$bridge_bin" status "$host" --json 2>/dev/null)"; then
	echo ":key.fill: | symbolize=true color=red"
	echo "---"
	echo "Bridge status failed | color=red"
	echo "Check in Terminal | bash='$bridge_bin' param1=status param2='$host' terminal=true"
	exit 0
fi

state="$(printf '%s' "$status_json" | "$jq_bin" -r '.state')"
tailscale="$(printf '%s' "$status_json" | "$jq_bin" -r '.tailscale')"
service="$(printf '%s' "$status_json" | "$jq_bin" -r '.service')"
transport="$(printf '%s' "$status_json" | "$jq_bin" -r '.transport')"
local_agent="$(printf '%s' "$status_json" | "$jq_bin" -r '.local_agent')"

case "$state" in
	connected)
		color="#30d158"
		label="Connected"
		;;
	retrying)
		color="#ffd60a"
		label="Reconnecting"
		;;
	waiting)
		color="#8e8e93"
		label="Waiting"
		;;
	stopped)
		color="#8e8e93"
		label="Stopped"
		;;
	*)
		color="#ff453a"
		label="Error"
		;;
esac

echo ":key.fill: | symbolize=true color=$color"
echo "---"
echo "1Password → $host: $label | color=$color"
echo "Tailscale: $tailscale"
echo "Service: $service"
echo "Transport: $transport"
echo "Local agent: $local_agent"
echo "Checked: $(date '+%H:%M:%S') | color=#8e8e93"
echo "---"

if [[ "$service" == running ]]; then
	echo "Reconnect | bash='$bridge_bin' param1=restart param2='$host' terminal=false refresh=true"
	echo "Stop | bash='$bridge_bin' param1=stop param2='$host' terminal=false refresh=true"
else
	echo "Start | bash='$bridge_bin' param1=start param2='$host' terminal=false refresh=true"
fi

echo "Probe remote agent… | bash='$bridge_bin' param1=check param2='$host' terminal=true"
echo "Follow logs… | bash='$bridge_bin' param1=logs param2='$host' terminal=true"
echo "Refresh | refresh=true"
