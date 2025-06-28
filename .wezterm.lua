-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = "nightfox"

config.inactive_pane_hsb = {
  saturation = 1,
  brightness = 1,
}

config.font_size = 14.0
config.hide_tab_bar_if_only_one_tab = true

return config
