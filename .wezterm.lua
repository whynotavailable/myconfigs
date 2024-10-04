-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

local carbonfox = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
carbonfox.split = carbonfox.foreground

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_schemes = {
	["my_carbonfox"] = carbonfox,
}

config.color_scheme = "my_carbonfox"

local mod_keys = "CTRL|SHIFT"

config.inactive_pane_hsb = {
	saturation = 1,
	brightness = 1,
}

config.font_size = 14.0
config.hide_tab_bar_if_only_one_tab = true

config.keys = {
	{ key = "LeftArrow", mods = mod_keys, action = act.ActivateTabRelative(-1) },
	{ key = "RightArrow", mods = mod_keys, action = act.ActivateTabRelative(1) },
	{
		key = "w",
		mods = mod_keys,
		action = act.CloseCurrentPane({ confirm = false }),
	},
	{ key = "{", mods = mod_keys, action = act.MoveTabRelative(-1) },
	{ key = "}", mods = mod_keys, action = act.MoveTabRelative(1) },
	{
		key = "Enter",
		mods = mod_keys,
		action = act.SplitPane({
			direction = "Down",
			size = { Percent = 15 },
		}),
	},
	{
		key = "UpArrow",
		mods = mod_keys,
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = mod_keys,
		action = act.ActivatePaneDirection("Down"),
	},
}

return config
