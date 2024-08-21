local wez = require "wezterm" ---@class WezTerm
local fun = require "utils.fun" ---@class Fun
local icons = require "utils.icons" ---@class Icons
local palettes = require "colors"

local module = {}

function module.get_config()
  ---@class Config
  local Config = {}

  Config.color_scheme_dirs = {
    -- 'C:\\users\\chiel.tenbrinke\\dotfiles\\neo-ansi\\terms\\wezterm\\generated',
    -- 'C:\\users\\chiel.tenbrinke\\dotfiles\\wezterm\\color-schemes',
  }

  wez.log_info("get_appearance (in config):")
  wez.log_info(wez.gui.get_appearance())

  -- local scheme = "classic-neo-ansi"
  local scheme = "lux-neo-ansi"
  -- local scheme = "tropical-neo-ansi"
  -- local scheme = "synthwave-material-neo-ansi"
  if ((wez.gui and wez.gui.get_appearance()) or "Dark"):find "Dark" then
    scheme = "synthwave-material-neo-ansi"
  end
  -- Config.color_schemes = require "colors"
  -- Config.color_scheme = scheme

  Config.colors = palettes[scheme]
  Config.colors.tab_bar = {
    background = Config.colors.background,
  }

  wez.log_info(scheme)

  Config.enable_kitty_graphics = true

  Config.inactive_pane_hsb = {
    saturation = 1.0,
    brightness = 0.8,
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


  Config.enable_tab_bar = true
  Config.hide_tab_bar_if_only_one_tab = false
  Config.show_new_tab_button_in_tab_bar = true
  Config.show_tab_index_in_tab_bar = false
  Config.show_tabs_in_tab_bar = true
  Config.switch_to_last_active_tab_when_closing_tab = false
  Config.tab_and_split_indices_are_zero_based = false
  Config.tab_bar_at_bottom = true
  Config.tab_max_width = 25
  Config.use_fancy_tab_bar = false


  ---new tab button
  Config.tab_bar_style = {}
  for _, tab_button in ipairs { "new_tab", "new_tab_hover" } do
    Config.tab_bar_style[tab_button] = wez.format {
      { Text = "\x1b[7m" },
      { Text = "\x1b[48:5:232:0m" },
      { Text = tab_button == "new_tab_hover" and "\x1b[38:5:251:0m" or "\x1b[38:5:245:0m" },
      { Text = icons.Separators.TabBar.right },
      { Text = " + " },
      { Text = icons.Separators.TabBar.left },
    }
  end

  -- The remainder of the tab bar text is done in the format-tab-title event

  return Config
end

return module
