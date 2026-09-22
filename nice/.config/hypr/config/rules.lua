hl.window_rule({
    name = "satty",
    match = { class = "org.satty.satty" },
    float = true,
    center = true,
    size = "(monitor_w*0.85) (monitor_h*0.85)",
})

hl.window_rule({
    name = "clipse",
    match = { title = "^clipse$" },
    float = true,
    center = true,
    pin = true,
    stay_focused = true,
    dim_around = true,
    size = "(monitor_w*0.55) (monitor_h*0.65)",
})
