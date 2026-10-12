local wezterm = require("wezterm")

return {
	font = wezterm.font_with_fallback({
		"JetBrainsMono Nerd Font",
		"Noto Color Emoji",
	}),
	font_size = 13.0,

	window_background_opacity = 0.85,
	warn_about_missing_glyphs = false,
	window_close_confirmation = "NeverPrompt",

	colors = {
		-- Основные цвета
		foreground = "#c5bfd2",
		background = "#08070c",

		cursor_bg = "#a99abb",
		cursor_fg = "#08070c",

		selection_bg = "#393044",
		selection_fg = "#e1dbea",

		-- Обычные ANSI-цвета
		ansi = {
			"#17121f", -- black
			"#9b6f87", -- red
			"#739b8b", -- green
			"#9d8d70", -- yellow
			"#625d8f", -- blue  ← вот этот
			"#91749f", -- magenta
			"#718b96", -- cyan
			"#b5afc2", -- white
		},

		brights = {
			"#443b50",
			"#b27f98",
			"#91aa99",
			"#ad9c7c",
			"#8078ae", -- bright blue
			"#ad8abc",
			"#8daab4",
			"#d0c9d8",
		},
	},

	enable_tab_bar = false,
}
