-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
config.audible_bell = "Disabled"
config.adjust_window_size_when_changing_font_size = false
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.term = "xterm-256color-italic"
config.window_close_confirmation = "NeverPrompt"
config.max_fps = 240
config.font = wezterm.font("GeistMono Nerd Font Mono")
config.line_height = 1.5
config.font_size = 24

config.color_scheme = "OceanicNext (base16)"
config.colors = {
	foreground = "white",
	ansi = {
		"#1b2b34",
		"#ec5f67",
		"#99c794",
		"#fac863",
		"#6699cc",
		"#c594c5",
		"#5fb3b3",
		"#ffffff",
	},
	brights = {
		"#67727c",
		"#ec5f67",
		"#99c794",
		"#fac863",
		"#6699cc",
		"#c594c5",
		"#5fb3b3",
		"#ffffff",
	},
}
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.keys = {
	{
		key = "Enter",
		mods = "CMD",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "t",
		mods = "CMD",
		action = wezterm.action.Nop,
	},
	{
		key = "n",
		mods = "CMD",
		action = wezterm.action.Nop,
	},
}
config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CMD",
		action = wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor("ClipboardAndPrimarySelection"),
	},
}
return config
