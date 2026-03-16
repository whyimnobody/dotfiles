#!/bin/bash

# <xbar.title>Homebrew Services</xbar.title>
# <xbar.version>v1.1</xbar.version>
# <xbar.author>whyimnobody</xbar.author>
# <xbar.author.github>whyimnobody</xbar.author.github>
# <xbar.desc>Shows Homebrew service status in a single SwiftBar menu.</xbar.desc>
# <xbar.dependencies>bash,brew</xbar.dependencies>
# <swiftbar.refreshOnOpen>true</swiftbar.refreshOnOpen>

set -euo pipefail

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

BREW_BIN="${HOMEBREW_BREW_FILE:-$(command -v brew || true)}"
if [ -z "${BREW_BIN}" ]; then
  echo "Services"
  echo "---"
  echo "Homebrew not found"
  exit 0
fi

run_brew_services() {
  env -u TMUX "${BREW_BIN}" services list
}

run_service_action() {
  local action="$1"
  local service="$2"

  env -u TMUX "${BREW_BIN}" services "${action}" "${service}" >/dev/null 2>&1
}

if [ "${#}" -ge 2 ]; then
  action="$1"
  service="$2"

  case "${action}" in
  start | stop | restart)
    run_service_action "${action}" "${service}"
    ;;
  esac

  exit 0
fi

echo ":gearshape.fill: | symbolize=true emojize=false"
echo "---"

list_output="$(run_brew_services 2>/dev/null || true)"

if [ -z "${list_output}" ]; then
  echo "No Homebrew services found"
  exit 0
fi

service_rows="$(printf '%s\n' "${list_output}" | awk 'NR > 1 && NF >= 2 { print $1 "\t" $2 }' | sort)"

if [ -z "${service_rows}" ]; then
  echo "No Homebrew services found"
  exit 0
fi

while IFS=$'\t' read -r name status; do
  [ -n "${name}" ] || continue

  marker="🔴"
  suffix=" (${status})"
  if [ "${status}" = "started" ]; then
    marker="🟢"
    suffix=""
  fi

  echo "${marker}  ${name}${suffix}"
  if [ "${status}" = "started" ]; then
    echo "--Restart | bash='$0' param1=restart param2='${name}' terminal=false refresh=true"
    echo "--Stop | bash='$0' param1=stop param2='${name}' terminal=false refresh=true"
  else
    echo "--Start | bash='$0' param1=start param2='${name}' terminal=false refresh=true"
  fi
done <<<"${service_rows}"
