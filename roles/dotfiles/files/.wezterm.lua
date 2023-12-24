local wezterm = require("wezterm")
local config = {}

config.color_scheme = "Catppuccin Mocha"
config.font_size = 14
config.scrollback_lines = 10000
config.enable_scroll_bar = true

config.hide_tab_bar_if_only_one_tab = true
config.enable_tab_bar = false
config.window_decorations = "RESIZE"

config.hyperlink_rules = wezterm.default_hyperlink_rules()
config.send_composed_key_when_left_alt_is_pressed = true

config.term = "xterm-256color"
return config
