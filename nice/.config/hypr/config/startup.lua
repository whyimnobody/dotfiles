local programs = require("config.programs")

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar & hyprpaper")
    hl.exec_cmd("kanshi")
    hl.exec_cmd("eww daemon")
    hl.exec_cmd("swaync")
    hl.exec_cmd("vicinae server")
    hl.exec_cmd("clipse -listen")
    hl.exec_cmd("1password --silent")
    hl.exec_cmd(programs.browser)
    hl.exec_cmd("steam -silent & disown")
    hl.exec_cmd("hypridle")
end)
