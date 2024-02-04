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

-- Tab bar styling
config.tab_bar_style = {
	-- active_tab_left = wezterm.format({
	--  { Background = { Color = "#0b0022" } },
	-- 	{ Foreground = { Color = "#2b2042" } },
	-- 	{ Text = "B" },
	-- }),
	-- active_tab_right = wezterm.format({
	-- 	{ Background = { Color = "#0b0022" } },
	-- 	{ Foreground = { Color = "#2b2042" } },
	-- 	{ Text = "h" },
	-- }),
	-- inactive_tab_left = wezterm.format({
	-- 	{ Background = { Color = "#0b0022" } },
	-- 	{ Foreground = { Color = "#1b1032" } },
	-- 	{ Text = "B" },
	-- }),
	-- inactive_tab_right = wezterm.format({
	-- 	{ Background = { Color = "#0b0022" } },
	-- 	{ Foreground = { Color = "#1b1032" } },
	-- 	{ Text = "h" },
	-- }),
}

--Font
config.font = wezterm.font("JetBrainsMono Nerd Font")

-- Actual configuration
return {
	-- Hide title bar and enable resizable window
	window_decorations = "RESIZE",
	use_dead_keys = false,
	scrollback_lines = 5000,
	-- Visual indication of pane focus
	inactive_pane_hsb = {
		saturation = 0.7,
		brightness = 0.6,
	},
	-- Theming and other visual settings
	color_scheme = "Catppuccin Mocha",
	use_fancy_tab_bar = false,
}
