-- Caelestia shell integration.
--
-- The primary launcher, sidebar, notification, and clipboard bindings live in
-- config.keybindings.lua. These alternate chords expose additional shell and
-- utility actions without disturbing the retained application shortcuts.

local programs = require("config.programs")
local main_mod = "SUPER"

local function bind(key, dispatcher, flags)
    hl.bind(key, dispatcher, flags)
end

local function shell(key, action, flags)
    bind(key, hl.dsp.global("caelestia:" .. action), flags)
end

local locked = { locked = true }
local repeating = { locked = true, repeating = true }

-- Alternate shell controls.
shell(main_mod .. " + ALT + SPACE", "launcher")
shell(main_mod .. " + ALT + N", "sidebar")
shell(main_mod .. " + ALT + K", "showall")
shell("CTRL + ALT + C", "clearNotifs", locked)
shell("CTRL + ALT + DELETE", "session")
shell(main_mod .. " + ALT + L", "lock")

-- Caelestia utilities. Existing Satty screenshot bindings remain unchanged.
shell(main_mod .. " + ALT + S", "screenshotFreeze")
shell(main_mod .. " + SHIFT + ALT + S", "screenshot")
bind("CTRL + ALT + R", hl.dsp.exec_cmd("caelestia record"))
bind(main_mod .. " + ALT + R", hl.dsp.exec_cmd("caelestia record -s"))
bind(main_mod .. " + SHIFT + ALT + R", hl.dsp.exec_cmd("caelestia record -r"))
bind(main_mod .. " + SHIFT + ALT + C", hl.dsp.exec_cmd("hyprpicker -a"))

-- Media controls complement the existing XF86 playerctl bindings.
shell("CTRL + " .. main_mod .. " + SPACE", "mediaToggle", locked)
shell("CTRL + " .. main_mod .. " + EQUAL", "mediaNext", locked)
shell("CTRL + " .. main_mod .. " + MINUS", "mediaPrev", locked)
shell("CTRL + " .. main_mod .. " + BACKSPACE", "mediaStop", locked)

-- Caelestia-style window controls, on alternate chords.
for key, direction in pairs({
    LEFT = "left",
    RIGHT = "right",
    UP = "up",
    DOWN = "down",
}) do
    bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = direction }))
end

bind(main_mod .. " + Z", hl.dsp.window.drag())
bind(main_mod .. " + X", hl.dsp.window.resize())
bind(main_mod .. " + ALT + C", hl.dsp.window.center())
bind(main_mod .. " + ALT + P", hl.dsp.window.pin())
bind(main_mod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
bind(main_mod .. " + ALT + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
bind(main_mod .. " + SHIFT + SPACE", hl.dsp.window.float())
bind(main_mod .. " + ALT + Q", hl.dsp.window.close())
bind(main_mod .. " + TAB", hl.dsp.window.cycle_next(), { repeating = true })

-- Adjacent workspace navigation and Caelestia's special workspace targets.
bind(main_mod .. " + ALT + LEFT", hl.dsp.focus({ workspace = "-1" }), repeating)
bind(main_mod .. " + ALT + RIGHT", hl.dsp.focus({ workspace = "+1" }), repeating)
bind(main_mod .. " + SHIFT + ALT + LEFT", hl.dsp.window.move({ workspace = "-1" }), repeating)
bind(main_mod .. " + SHIFT + ALT + RIGHT", hl.dsp.window.move({ workspace = "+1" }), repeating)
bind(main_mod .. " + ALT + M", hl.dsp.workspace.toggle_special("music"))
bind(main_mod .. " + ALT + D", hl.dsp.workspace.toggle_special("communication"))
bind(main_mod .. " + CTRL + ALT + R", hl.dsp.workspace.toggle_special("todo"))
bind(main_mod .. " + CTRL + ALT + ESCAPE", hl.dsp.workspace.toggle_special("sysmon"))

-- Caelestia's clipboard and emoji helpers. They become available with the
-- CLI; until then these commands simply fail harmlessly when invoked.
bind(main_mod .. " + ALT + V", hl.dsp.exec_cmd("pkill fuzzel || caelestia clipboard"))
bind("CTRL + SHIFT + ALT + V", hl.dsp.exec_cmd("pkill fuzzel || caelestia clipboard -d"))
bind(main_mod .. " + PERIOD", hl.dsp.exec_cmd("pkill fuzzel || caelestia emoji -p"))

-- Keep the Caelestia app roles reachable without changing the terminal,
-- file-manager, browser, and editor choices.
bind(main_mod .. " + ALT + T", hl.dsp.exec_cmd(programs.terminal))
bind(main_mod .. " + ALT + W", hl.dsp.exec_cmd(programs.browser))
bind(main_mod .. " + ALT + I", hl.dsp.exec_cmd("ghostty -e nvim"))
bind(main_mod .. " + ALT + E", hl.dsp.exec_cmd(programs.file_manager))
