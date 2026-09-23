#!/usr/bin/env bash

set -euo pipefail

screenshot_dir="$HOME/Downloads/Screenshots"
mkdir -p "$screenshot_dir"

annotate() {
	local output="${1:-}"
	if [[ -n "$output" ]]; then
		hyprctl dispatch focusmonitor "$output" >/dev/null
	fi
	satty --filename -
}

monitor_for_geometry() {
	local geometry="$1"
	local position="${geometry%% *}"
	local dimensions="${geometry##* }"
	local x="${position%,*}"
	local y="${position#*,}"
	local width="${dimensions%x*}"
	local height="${dimensions#*x}"
	local center_x=$((x + width / 2))
	local center_y=$((y + height / 2))

	hyprctl monitors -j | jq -er \
		--argjson x "$center_x" \
		--argjson y "$center_y" \
		'.[] | select(
			$x >= .x and $x < (.x + (.width / .scale)) and
			$y >= .y and $y < (.y + (.height / .scale))
		) | .name'
}

case "${1:-region}" in
	region)
		if ! geometry="$(slurp -d)"; then
			exit 0
		fi
		output="$(monitor_for_geometry "$geometry")"
		grim -g "$geometry" -t ppm - | annotate "$output"
		;;
	copy)
		if ! geometry="$(slurp -d)"; then
			exit 0
		fi
		grim -g "$geometry" -t png - | wl-copy --type image/png
		;;
	screen)
		output="$(hyprctl monitors -j | jq -er '.[] | select(.focused) | .name')"
		grim -o "$output" -t ppm - | annotate "$output"
		;;
	window)
		geometry="$(
			hyprctl activewindow -j |
				jq -er '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"'
		)"
		grim -g "$geometry" -t ppm - | annotate
		;;
	*)
		printf 'Usage: %s {region|copy|screen|window}\n' "${0##*/}" >&2
		exit 2
		;;
esac
