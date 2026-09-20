#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_config="$repo_root/caddy/Caddyfile"

if ! command -v caddy >/dev/null 2>&1; then
	echo "Caddy is not installed" >&2
	exit 1
fi

# Keep machine-local `caddy-add-site` blocks (between # >>> devports / # <<<
# devports). The repo Caddyfile owns syncthing.localhost, syncthing.asura,
# email.test, and jupyter.test; skip any local block whose hostname is already
# in the repo file.
managed_caddy_hosts() {
	awk '
		$0 ~ /^https?:\/\// {
			host = $1
			sub(/^https?:\/\//, "", host)
			print host
			next
		}
		$0 ~ /^[A-Za-z0-9._-]+\.(test|localhost|asura)[[:space:]]*\{/ {
			print $1
		}
	' "$1" | paste -sd, -
}

extract_devports() {
	local file="$1"
	local managed="$2"

	[[ -f "$file" ]] || return 0
	awk -v managed="$managed" '
		BEGIN {
			n = split(managed, parts, ",")
			for (i = 1; i <= n; i++) {
				if (parts[i] != "") skiphost[parts[i]] = 1
			}
		}
		/^# >>> devports:/ {
			dropping = (($4 ".test") in skiphost)
			inblock = 1
			if (!dropping) print
			next
		}
		inblock && /^# <<< devports$/ {
			if (!dropping) print
			inblock = 0
			dropping = 0
			next
		}
		inblock && !dropping { print }
	' "$file"
}

merge_caddyfile() {
	local source="$1"
	local target="$2"
	local dest="$3"
	local extra
	local managed

	managed="$(managed_caddy_hosts "$source")"
	cat "$source" >"$dest"
	extra="$(extract_devports "$target" "$managed")"
	if [[ -n "$extra" ]]; then
		printf '\n%s' "$extra" >>"$dest"
		[[ -z "$(tail -c 1 "$dest")" ]] || printf '\n' >>"$dest"
	fi
}

install_if_changed() {
	local merged="$1"
	local target="$2"

	if [[ -f "$target" ]] && cmp -s "$merged" "$target"; then
		return 1
	fi
	return 0
}

install_dnsmasq_devports() {
	local template="$repo_root/caddy/dnsmasq-devports.conf"
	local target=/etc/dnsmasq.d/devports.conf
	local ip rendered

	if ! command -v tailscale >/dev/null 2>&1; then
		echo "Skipping dnsmasq *.asura/*.test: tailscale is not installed" >&2
		return 0
	fi
	ip="$(tailscale ip -4)"
	if [[ -z "$ip" ]]; then
		echo "Skipping dnsmasq *.asura/*.test: no Tailscale IPv4" >&2
		return 0
	fi
	rendered="$(mktemp)"
	sed "s/__TAILSCALE_IPV4__/${ip}/g" "$template" >"$rendered"
	if [[ -f "$target" ]] && cmp -s "$rendered" "$target"; then
		rm -f "$rendered"
		return 0
	fi
	sudo install -Dm644 "$rendered" "$target"
	rm -f "$rendered"
	sudo systemctl reload-or-restart dnsmasq.service
}

case "$(uname -s)" in
	Darwin)
		brew_prefix="$(brew --prefix)"
		target_config="$brew_prefix/etc/Caddyfile"
		merged="$(mktemp)"
		trap 'rm -f "$merged"' EXIT
		merge_caddyfile "$source_config" "$target_config" "$merged"
		caddy validate --config "$merged" --adapter caddyfile
		if install_if_changed "$merged" "$target_config"; then
			install -m 644 "$merged" "$target_config"
			sudo brew services restart caddy
		else
			sudo brew services start caddy
		fi
		sudo env XDG_DATA_HOME="$brew_prefix/var/lib" caddy trust
		;;
	Linux)
		target_config=/etc/caddy/Caddyfile
		merged="$(mktemp)"
		trap 'rm -f "$merged"' EXIT
		merge_caddyfile "$source_config" "$target_config" "$merged"
		caddy validate --config "$merged" --adapter caddyfile
		config_changed=false
		if install_if_changed "$merged" "$target_config"; then
			sudo install -Dm644 "$merged" "$target_config"
			config_changed=true
		fi
		sudo systemctl enable --now caddy.service
		if [[ "$config_changed" == true ]]; then
			sudo systemctl reload-or-restart caddy.service
		fi
		sudo env XDG_DATA_HOME=/var/lib caddy trust
		install_dnsmasq_devports
		;;
	*)
		echo "Unsupported operating system: $(uname -s)" >&2
		exit 1
		;;
esac

echo "Caddy is serving https://syncthing.localhost, http://syncthing.asura, http://email.test, and http://jupyter.test"
