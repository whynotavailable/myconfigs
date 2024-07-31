-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

config.inactive_pane_hsb = {
	saturation = 1,
	brightness = 1,
}

-- This is where you actually apply your config choices
config.font_size = 14.0
config.hide_tab_bar_if_only_one_tab = true
-- and finally, return the configuration to wezterm

config.keys = {
	{ key = "LeftArrow", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "RightArrow", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(1) },
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = act.CloseCurrentPane({ confirm = false }),
	},
	{ key = "{", mods = "CTRL|SHIFT", action = act.MoveTabRelative(-1) },
	{ key = "}", mods = "CTRL|SHIFT", action = act.MoveTabRelative(1) },
	{
		key = "Enter",
		mods = "CTRL|SHIFT",
		action = act.SplitPane({
			direction = "Down",
			size = { Percent = 15 },
		}),
	},
	{
		key = "UpArrow",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Down"),
	},
}

return config
