-- Shake-to-find. Do not call hl.plugin.load here: loading a plugin
-- during config reload re-enters reload and crashes Hyprland.
-- The .so is loaded from startup.lua after the compositor is up.
-- Built for Hyprland 0.56.2 (hypr-dynamic-cursors 5a22428).
if hl.plugin.dynamic_cursors then
	hl.config({
		plugin = {
			dynamic_cursors = {
				mode = "none",
				shake = {
					enabled = true,
				},
			},
		},
	})
end
