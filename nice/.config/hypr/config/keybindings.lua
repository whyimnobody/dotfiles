local programs = require("config.programs")
local main_mod = "SUPER"

hl.bind(main_mod .. " + Q", hl.dsp.exec_cmd(programs.terminal))
hl.bind(main_mod .. " + SHIFT + K", hl.dsp.window.close())
hl.bind(main_mod .. " + M", hl.dsp.exit())
hl.bind(main_mod .. " + E", hl.dsp.exec_cmd(programs.file_manager))
hl.bind(main_mod .. " + V", hl.dsp.exec_cmd("ghostty --class=clipse --title=clipse -e clipse"))
hl.bind(main_mod .. " + SHIFT + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(main_mod .. " + SPACE", hl.dsp.exec_cmd(programs.menu))
hl.bind(main_mod .. " + P", hl.dsp.window.pseudo())
hl.bind(main_mod .. " + N", hl.dsp.exec_cmd("swaync-client -t"))
hl.bind(main_mod .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client -C"))
hl.bind(main_mod .. " + CTRL + ESCAPE", hl.dsp.exec_cmd("eww kill"))

hl.bind(main_mod .. " + SHIFT + S", hl.dsp.exec_cmd("~/.dotfiles/scripts/screenshot.sh region"))
hl.bind(main_mod .. " + SHIFT + C", hl.dsp.exec_cmd("~/.dotfiles/scripts/screenshot.sh copy"))
hl.bind(main_mod .. " + SHIFT + F", hl.dsp.exec_cmd("~/.dotfiles/scripts/screenshot.sh screen"))
hl.bind(main_mod .. " + SHIFT + W", hl.dsp.exec_cmd("~/.dotfiles/scripts/screenshot.sh window"))

for key, direction in pairs({
    left = "left",
    right = "right",
    up = "up",
    down = "down",
}) do
    hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ direction = direction }))
end

for key, direction in pairs({
    H = "left",
    L = "right",
    K = "up",
    J = "down",
}) do
    hl.bind(main_mod .. " + " .. key, hl.dsp.window.move({ direction = direction }))
end

for workspace = 1, 10 do
    local key = tostring(workspace % 10)
    hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
    hl.bind(main_mod .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = workspace }))
end

hl.bind(main_mod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(main_mod .. " + CTRL + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(main_mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(main_mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
