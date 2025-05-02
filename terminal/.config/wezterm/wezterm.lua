-- Configuration inspired by https://hackernoon.com/get-the-most-out-of-your-terminal-a-comprehensive-guide-to-wezterm-configuration

local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()
local mux = wezterm.mux

-- Windows and pane navigation
local function isViProcess(pane)
	-- get_foreground_process_name On Linux, macOS and Windows,
	-- the process can be queried to determine this path. Other operating systems
	-- (notably, FreeBSD and other unix systems) are not currently supported
	return pane:get_foreground_process_name():find("n?vim") ~= nil
	-- return pane:get_title():find("n?vim") ~= nil
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
	if isViProcess(pane) then
		window:perform_action(
			-- This should match the keybinds you set in Neovim.
			act.SendKey({ key = vim_direction, mods = "ALT" }),
			pane
		)
	else
		window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
	end
end

wezterm.on("ActivatePaneDirection-right", function(window, pane)
	conditionalActivatePane(window, pane, "Right", "l")
end)
wezterm.on("ActivatePaneDirection-left", function(window, pane)
	conditionalActivatePane(window, pane, "Left", "h")
end)
wezterm.on("ActivatePaneDirection-up", function(window, pane)
	conditionalActivatePane(window, pane, "Up", "k")
end)
wezterm.on("ActivatePaneDirection-down", function(window, pane)
	conditionalActivatePane(window, pane, "Down", "j")
end)

-- Define colors and styles
local colors = {
	active_tab_bg = "#2b2042",
	active_tab_fg = "#c0c0c0",
	inactive_tab_bg = "#1b1032",
	inactive_tab_fg = "#808080",
	hover_tab_bg = "#3b3052",
	hover_tab_fg = "#909090",
}

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = tab.active_pane.title

	if tab.is_active then
		return {
			{ Background = { Color = colors.active_tab_bg } },
			{ Foreground = { Color = colors.active_tab_fg } },
			{ Text = "   " .. title .. "   " },
		}
	elseif hover then
		return {
			{ Background = { Color = colors.hover_tab_bg } },
			{ Foreground = { Color = colors.hover_tab_fg } },
			{ Text = "   " .. title .. "   " },
		}
	else
		return {
			{ Background = { Color = colors.inactive_tab_bg } },
			{ Foreground = { Color = colors.inactive_tab_fg } },
			{ Text = "   " .. title .. "   " },
		}
	end
end)

-- local TAB_END = " ";
local TAB_END = wezterm.nerdfonts.ple_right_half_circle_thick

-- Actual configuration
return {
	--Font
	font = wezterm.font_with_fallback({ "CommitMono Nerd Font" }),
	font_size = 12.0,
	line_height = 1.25,
	-- Hide title bar and enable resizable window
	window_decorations = "RESIZE",
	hide_tab_bar_if_only_one_tab = false,
	tab_bar_at_bottom = false,
	tab_max_width = 16,
	use_fancy_tab_bar = true,
	-- use_dead_keys = false,
	scrollback_lines = 200000,
	-- Visual indication of pane focus
	inactive_pane_hsb = {
		saturation = 0.7,
		brightness = 0.6,
	},
	-- Theming and other visual settings
	color_scheme = "Catppuccin Mocha",
}
