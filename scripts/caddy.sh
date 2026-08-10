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
		install -m 644 "$source_config" "$brew_prefix/etc/Caddyfile"
		sudo brew services restart caddy
		sudo env XDG_DATA_HOME="$brew_prefix/var/lib" caddy trust
		;;
	Linux)
		sudo install -Dm644 "$source_config" /etc/caddy/Caddyfile
		sudo systemctl enable --now caddy.service
		sudo systemctl reload-or-restart caddy.service
		sudo env XDG_DATA_HOME=/var/lib caddy trust
		;;
	*)
		echo "Unsupported operating system: $(uname -s)" >&2
		exit 1
		;;
esac

echo "Caddy is serving https://syncthing.localhost"
