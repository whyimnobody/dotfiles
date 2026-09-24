local programs = require("config.programs")

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

hl.on("hyprland.start", function()
	hl.exec_cmd("/home/seven/.local/bin/caelestia-local shell -d")
    hl.exec_cmd("kanshi")
    hl.exec_cmd("1password --silent")
    hl.exec_cmd(programs.browser)
    hl.exec_cmd("steam -silent & disown")
end)
