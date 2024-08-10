local wez = require "wezterm" ---@class WezTerm

---@class Config
local Config = {}

Config.color_scheme_dirs = {
  -- 'C:\\users\\chiel.tenbrinke\\dotfiles\\neo-ansi\\terms\\wezterm\\generated',
  -- 'C:\\users\\chiel.tenbrinke\\dotfiles\\wezterm\\color-schemes',
}


local scheme = "lux-neo-ansi"
if ((wez.gui and wez.gui.get_appearance()) or "Dark"):find "Dark" then
  scheme = "synthwave-material-neo-ansi"
end
local theme = require("colors")[scheme]
Config.color_schemes = require "colors"
Config.color_scheme = scheme

wez.log_info(scheme)

Config.hide_tab_bar_if_only_one_tab = false
Config.use_fancy_tab_bar = false
Config.tab_bar_at_bottom = true
Config.enable_kitty_graphics=true

Config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.9,
}

-- Config.background = {
--   {
--     source = { Color = theme.background },
--     width = "100%",
--     height = "100%",
--   },
-- }

-- Config.bold_brightens_ansi_colors = "BrightAndBold"
Config.bold_brightens_ansi_colors = "No"

---char select and command palette
-- Config.char_select_bg_color = theme.brights[6]
-- Config.char_select_fg_color = theme.background
-- Config.char_select_font_size = 12

-- Config.command_palette_bg_color = theme.brights[6]
-- Config.command_palette_fg_color = theme.background
-- Config.command_palette_font_size = 14
-- Config.command_palette_rows = 20

---cursor
Config.cursor_blink_ease_in = "EaseIn"
Config.cursor_blink_ease_out = "EaseOut"
Config.cursor_blink_rate = 500
Config.default_cursor_style = "BlinkingUnderline"
Config.cursor_thickness = 1
Config.force_reverse_video_cursor = true

Config.enable_scroll_bar = true

Config.hide_mouse_cursor_when_typing = true

---text blink
Config.text_blink_ease_in = "EaseIn"
Config.text_blink_ease_out = "EaseOut"
Config.text_blink_rapid_ease_in = "Linear"
Config.text_blink_rapid_ease_out = "Linear"
Config.text_blink_rate = 500
Config.text_blink_rate_rapid = 250

---visual bell
Config.audible_bell = "Disabled"
-- Config.visual_bell = {
--   fade_in_function = "EaseOut",
--   fade_in_duration_ms = 200,
--   fade_out_function = "EaseIn",
--   fade_out_duration_ms = 200,
-- }

---window appearance
Config.window_padding = { left = 2, right = 2, top = 2, bottom = 1 }
Config.window_decorations = "RESIZE"
Config.integrated_title_button_alignment = "Right"
Config.integrated_title_button_style = "Windows"
Config.integrated_title_buttons = { "Hide", "Maximize", "Close" }

---new tab button
Config.tab_bar_style = {}
for _, tab_button in ipairs { "new_tab", "new_tab_hover" } do
  Config.tab_bar_style[tab_button] = require("wezterm").format {
    { Text = "\x1b[7m" },
    { Text = "\x1b[48:5:235:0m" },
    { Text = "\x1b[38:5:252:0m" },
    { Text = require("utils.icons").Separators.TabBar.right },
    { Text = " + " },
    { Text = require("utils.icons").Separators.TabBar.left },
  }
end

return Config

