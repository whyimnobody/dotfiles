#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_config="$repo_root/caddy/Caddyfile"

if ! command -v caddy >/dev/null 2>&1; then
	echo "Caddy is not installed" >&2
	exit 1
fi

caddy validate --config "$source_config"

case "$(uname -s)" in
	Darwin)
		brew_prefix="$(brew --prefix)"
		target_config="$brew_prefix/etc/Caddyfile"
		if [[ ! -f "$target_config" ]] || ! cmp -s "$source_config" "$target_config"; then
			install -m 644 "$source_config" "$target_config"
			sudo brew services restart caddy
		else
			sudo brew services start caddy
		fi
		sudo env XDG_DATA_HOME="$brew_prefix/var/lib" caddy trust
		;;
	Linux)
		target_config=/etc/caddy/Caddyfile
		config_changed=false
		if [[ ! -f "$target_config" ]] || ! cmp -s "$source_config" "$target_config"; then
			sudo install -Dm644 "$source_config" "$target_config"
			config_changed=true
		fi
		sudo systemctl enable --now caddy.service
		if [[ "$config_changed" == true ]]; then
			sudo systemctl reload-or-restart caddy.service
		fi
		sudo env XDG_DATA_HOME=/var/lib caddy trust
		;;
	*)
		echo "Unsupported operating system: $(uname -s)" >&2
		exit 1
		;;
esac

echo "Caddy is serving https://syncthing.localhost"
