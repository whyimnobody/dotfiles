#!/usr/bin/env bash

set -euo pipefail

app_name=""
download_url=""
filename=""
desktop_id=""
icon_source=""
exec_args=""
comment=""
startup_wm_class=""
startup_notify=false
categories="Utility;"
mime_types=""
sha256=""
force=false
dry_run=false

usage() {
	cat <<'EOF'
Usage: scripts/appimage-install.sh --name NAME --url URL [options]

Install or update an AppImage for the current user and add a desktop entry.

Required:
  --name NAME          Application name shown in the launcher.
  --url URL            AppImage URL.

Options:
  --filename FILE      Installed filename; defaults to a slug made from NAME.
  --desktop-id FILE    Desktop entry filename; defaults to a slug-based ID.
  --icon PATH_OR_URL   Optional local icon path or downloadable icon URL.
  --exec-args ARGS     Arguments placed between the AppImage and %U in Exec.
  --comment TEXT       Optional launcher description.
  --startup-wm-class CLASS
                       Optional desktop window class.
  --startup-notify     Enable desktop startup notification.
  --categories VALUE   Desktop categories; defaults to Utility;.
  --mime-types VALUE   Optional semicolon-separated MIME types.
  --sha256 HASH        Verify the downloaded AppImage against a SHA-256 hash.
  --force              Replace an existing AppImage or desktop entry.
  --dry-run            Print resolved paths without changing anything.
  -h, --help           Show this help.

The XDG_DATA_HOME environment variable controls the user-local data root.
Downloads are only format-checked unless --sha256 is supplied; use trusted
URLs and checksums for security-sensitive applications.
EOF
}

die() {
	printf 'error: %s\n' "$1" >&2
	exit 1
}

while [[ $# -gt 0 ]]; do
	case "$1" in
		--name)
			[[ $# -ge 2 ]] || die "--name requires a value"
			app_name="$2"
			shift 2
			;;
		--url)
			[[ $# -ge 2 ]] || die "--url requires a value"
			download_url="$2"
			shift 2
			;;
		--filename)
			[[ $# -ge 2 ]] || die "--filename requires a value"
			filename="$2"
			shift 2
			;;
		--desktop-id)
			[[ $# -ge 2 ]] || die "--desktop-id requires a value"
			desktop_id="$2"
			shift 2
			;;
		--icon)
			[[ $# -ge 2 ]] || die "--icon requires a value"
			icon_source="$2"
			shift 2
			;;
		--exec-args)
			[[ $# -ge 2 ]] || die "--exec-args requires a value"
			exec_args="$2"
			shift 2
			;;
		--comment)
			[[ $# -ge 2 ]] || die "--comment requires a value"
			comment="$2"
			shift 2
			;;
		--startup-wm-class)
			[[ $# -ge 2 ]] || die "--startup-wm-class requires a value"
			startup_wm_class="$2"
			shift 2
			;;
		--startup-notify)
			startup_notify=true
			shift
			;;
		--categories)
			[[ $# -ge 2 ]] || die "--categories requires a value"
			categories="$2"
			shift 2
			;;
		--mime-types)
			[[ $# -ge 2 ]] || die "--mime-types requires a value"
			mime_types="$2"
			shift 2
			;;
		--sha256)
			[[ $# -ge 2 ]] || die "--sha256 requires a value"
			sha256="$2"
			shift 2
			;;
		--force)
			force=true
			shift
			;;
		--dry-run)
			dry_run=true
			shift
			;;
		-h|--help)
			usage
			exit 0
			;;
		*)
			usage >&2
			die "unknown argument: $1"
			;;
	esac
done

[[ -n "$app_name" ]] || die "--name is required"
[[ -n "$download_url" ]] || die "--url is required"
[[ -z "$sha256" || "$sha256" =~ ^[[:xdigit:]]{64}$ ]] || die "--sha256 must be a 64-character hexadecimal SHA-256 hash"
sha256="${sha256,,}"

validate_no_newlines() {
	local value="$1"
	local label="$2"
	[[ "$value" != *$'\n'* && "$value" != *$'\r'* ]] || die "$label must not contain newlines"
}

validate_no_newlines "$app_name" "--name"
validate_no_newlines "$download_url" "--url"
validate_no_newlines "$filename" "--filename"
validate_no_newlines "$desktop_id" "--desktop-id"
validate_no_newlines "$icon_source" "--icon"
validate_no_newlines "$exec_args" "--exec-args"
validate_no_newlines "$comment" "--comment"
validate_no_newlines "$startup_wm_class" "--startup-wm-class"
validate_no_newlines "$categories" "--categories"
validate_no_newlines "$mime_types" "--mime-types"
validate_no_newlines "$sha256" "--sha256"

slug="$(printf '%s' "$app_name" | tr '[:upper:]' '[:lower:]' | tr -cs '[:alnum:]._-' '-' | sed 's/^-*//;s/-*$//')"
[[ -n "$slug" ]] || die "could not derive a safe filename from --name"

if [[ -z "$filename" ]]; then
	filename="$slug.AppImage"
fi

if [[ -z "$desktop_id" ]]; then
	desktop_id="$slug.desktop"
elif [[ "$desktop_id" != *.desktop ]]; then
	desktop_id="$desktop_id.desktop"
fi
[[ "$desktop_id" != */* ]] || die "--desktop-id must be a filename, not a path"

data_home="${XDG_DATA_HOME:-$HOME/.local/share}"
app_dir="$data_home/AppImage"
applications_dir="$data_home/applications"
icons_dir="$data_home/icons"
app_path="$app_dir/$filename"
desktop_path="$applications_dir/$desktop_id"

if [[ "$dry_run" == true ]]; then
	printf 'name:     %s\n' "$app_name"
	printf 'download: %s\n' "$download_url"
	printf 'app:      %s\n' "$app_path"
	printf 'desktop:  %s\n' "$desktop_path"
	printf 'icon:     %s\n' "${icon_source:-bundled icon or generic launcher icon}"
	printf 'args:     %s\n' "${exec_args:-none}"
	printf 'sha256:   %s\n' "${sha256:-not verified}"
	printf 'force:    %s\n' "$force"
	exit 0
fi

if [[ "$force" != true && ( -e "$app_path" || -e "$desktop_path" ) ]]; then
	die "an AppImage or desktop entry already exists; review --dry-run and rerun with --force to replace it"
fi

required_commands=(curl file find install mktemp sed tr)
[[ -n "$sha256" ]] && required_commands+=(sha256sum)
for command in "${required_commands[@]}"; do
	command -v "$command" >/dev/null 2>&1 || die "required command not found: $command"
done

mkdir -p "$app_dir" "$applications_dir" "$icons_dir"

temp_app="$(mktemp "$app_dir/.$slug.AppImage.XXXXXX")"
extract_dir="$(mktemp -d "${TMPDIR:-/tmp}/appimage-install.XXXXXX")"
desktop_tmp="$(mktemp "$applications_dir/.$slug.XXXXXX.desktop")"
icon_tmp=""

cleanup() {
	[[ -n "$temp_app" ]] && rm -f -- "$temp_app"
	[[ -n "$desktop_tmp" ]] && rm -f -- "$desktop_tmp"
	[[ -n "$icon_tmp" ]] && rm -f -- "$icon_tmp"
	rm -rf -- "$extract_dir"
}
trap cleanup EXIT

printf 'Downloading %s...\n' "$app_name"
curl -fL --retry 3 --output "$temp_app" "$download_url"
chmod 0755 "$temp_app"

file_output="$(file -b "$temp_app")"
[[ "$file_output" == *ELF* ]] || die "downloaded file is not an ELF AppImage: $file_output"

if [[ -n "$sha256" ]]; then
	actual_sha256="$(sha256sum "$temp_app")"
	actual_sha256="${actual_sha256%% *}"
	[[ "$actual_sha256" == "$sha256" ]] || die "SHA-256 mismatch: expected $sha256, got $actual_sha256"
else
	printf 'warning: no SHA-256 supplied; trusting the download URL without integrity verification\n' >&2
fi

icon_path=""
install_icon() {
	local source="$1"
	local extension=".png"

	case "$source" in
		*.svg) extension=".svg" ;;
		*.jpg|*.jpeg) extension=".jpg" ;;
	esac

	icon_path="$icons_dir/$slug$extension"
	install -m 0644 "$source" "$icon_path"
}

if [[ -n "$icon_source" ]]; then
	if [[ "$icon_source" == http://* || "$icon_source" == https://* ]]; then
		icon_tmp="$(mktemp "$icons_dir/.$slug.icon.XXXXXX")"
		curl -fL --retry 3 --output "$icon_tmp" "$icon_source"
		install_icon "$icon_tmp"
	else
		[[ -f "$icon_source" ]] || die "icon file not found: $icon_source"
		install_icon "$icon_source"
	fi
else
	# AppImage extraction reads bundled metadata without launching the GUI.
	if (
		cd "$extract_dir"
		"$temp_app" --appimage-extract >/dev/null 2>&1
	); then
		bundled_root="$extract_dir/squashfs-root"
		bundled_icon=""
		for size in 512x512 256x256 128x128 64x64 48x48 32x32; do
			bundled_icon="$(find "$bundled_root/usr/share/icons" -path "*$size*" -type f \( -iname '*.png' -o -iname '*.svg' \) -print -quit 2>/dev/null || true)"
			[[ -n "$bundled_icon" ]] && break
		done
		if [[ -z "$bundled_icon" && -f "$bundled_root/resources/icon.png" ]]; then
			bundled_icon="$bundled_root/resources/icon.png"
		fi
		[[ -n "$bundled_icon" ]] && install_icon "$bundled_icon"
	fi
fi

mv -f -- "$temp_app" "$app_path"
temp_app=""

icon_entry="application-x-executable"
[[ -n "$icon_path" ]] && icon_entry="$icon_path"
exec_line="\"$app_path\""
[[ -n "$exec_args" ]] && exec_line+=" $exec_args"

cat >"$desktop_tmp" <<EOF
[Desktop Entry]
Name=$app_name
Exec=$exec_line %U
Terminal=false
Type=Application
Icon=$icon_entry
Categories=$categories
EOF

if [[ -n "$comment" ]]; then
	printf 'Comment=%s\n' "$comment" >>"$desktop_tmp"
fi
if [[ -n "$startup_wm_class" ]]; then
	printf 'StartupWMClass=%s\n' "$startup_wm_class" >>"$desktop_tmp"
fi
if [[ "$startup_notify" == true ]]; then
	printf 'StartupNotify=true\n' >>"$desktop_tmp"
fi
if [[ -n "$mime_types" ]]; then
	printf 'MimeType=%s\n' "$mime_types" >>"$desktop_tmp"
fi

if command -v desktop-file-validate >/dev/null 2>&1; then
	desktop-file-validate "$desktop_tmp" || die "generated desktop entry failed validation"
fi
install -m 0644 "$desktop_tmp" "$desktop_path"

if command -v update-desktop-database >/dev/null 2>&1; then
	update-desktop-database "$applications_dir"
else
	printf 'warning: update-desktop-database not found; the launcher may refresh later\n' >&2
fi

printf 'Installed %s at %s\n' "$app_name" "$app_path"
printf 'Launcher entry: %s\n' "$desktop_path"
