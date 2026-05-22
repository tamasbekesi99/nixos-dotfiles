hl.window_rule({
	match = {
		class = "^(kitty-scratchpad)$",
	},
	workspace = "special:kitty_scratch silent",
	float = true,
	size = "920 520",
	center = true,
	animation = "slide top",
})

hl.window_rule({
	match = {
		class = "^(kitty-notes)$",
	},
	workspace = "special:notes silent",
})

hl.on("hyprland.start", function()
	hl.exec_cmd('kitty --title "kitty-scratchpad" --class kitty-scratchpad')
	hl.exec_cmd(
		'kitty --title "kitty-notes" --class kitty-notes --config ~/.config/kitty/yellow-notes.conf -e nano ~/notes.txt'
	)
end)
