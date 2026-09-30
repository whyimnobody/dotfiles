local programs = require("config.programs")

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

hl.on("hyprland.start", function()
	-- Load after startup. hl.plugin.load inside the config file re-enters reload and crashes.
	hl.exec_cmd("hyprctl plugin load " .. os.getenv("HOME") .. "/.local/lib/hyprland/dynamic-cursors.so")
	hl.exec_cmd("/home/seven/.local/bin/caelestia-local shell -d")
    hl.exec_cmd("kanshi")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    -- 1Password only registers its tray icon if the StatusNotifier host
    -- already exists. The shell is still starting when this runs.
    hl.exec_cmd([[sh -c 'i=0; while [ "$i" -lt 50 ]; do busctl --user status org.kde.StatusNotifierWatcher >/dev/null 2>&1 && break; i=$((i+1)); sleep 0.1; done; exec 1password --silent']])
    hl.exec_cmd(programs.browser)
    hl.exec_cmd("steam -silent & disown")
end)
