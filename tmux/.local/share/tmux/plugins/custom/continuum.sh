show_continuum() {
	local index=$1
	local icon="$(get_tmux_option "@catppuccin_continuum_icon" "󰸨")"
	local color="$(get_tmux_option "@catppuccin_continuum_color" "$thm_yellow")"
	local text="$(get_tmux_option "@catppuccin_continuum_text" "#{continuum_status}")"

	local module=$(build_status_module "$index" "$icon" "$color" "$text")

	echo "$module"
}
