-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.font_size = 14.0
config.hide_tab_bar_if_only_one_tab = true
-- and finally, return the configuration to wezterm

config.keys = {
	{ key = "LeftArrow", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(1) },
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	{ key = "{", mods = "CTRL|SHIFT", action = wezterm.action.MoveTabRelative(-1) },
	{ key = "}", mods = "CTRL|SHIFT", action = wezterm.action.MoveTabRelative(1) },
}

return config
