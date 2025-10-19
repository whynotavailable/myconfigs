-- Pull in the wezterm API
local wezterm = require("wezterm")
-- This will hold the configuration.
local config = wezterm.config_builder()

config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.color_scheme = "nightfox"

config.inactive_pane_hsb = {
  saturation = 1,
  brightness = 1,
}

if wezterm.target_triple == "aarch64-apple-darwin" then
  config.font_size = 15.0
else
  config.font_size = 12.0
end

config.hide_tab_bar_if_only_one_tab = true

return config
