local wezterm = require 'wezterm';
local act = wezterm.action
local fun = require "utils.fun" ---@class Fun

---@class Config
local Config = {}

-- Config.disable_default_key_bindings = true

Config.keys = {
  { key = 'C', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
  { key = 'V', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
  { key = 'Insert', mods = 'CTRL', action = act.CopyTo 'PrimarySelection' },
  { key = 'Insert', mods = 'SHIFT', action = act.PasteFrom 'PrimarySelection' },
  { key = 'F', mods = 'SHIFT|CTRL', action = act.Search 'CurrentSelectionOrEmptyString' },
  { key = '=', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
  { key = '-', mods = 'SHIFT|CTRL', action = act.DecreaseFontSize },
  { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
  { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },

  { key = '~', mods = 'CTRL|SHIFT', action = act.ShowDebugOverlay, },
  { key = '?', mods = 'CTRL|SHIFT', action = act.ActivateCommandPalette, },
  { key = 'q', mods = 'CTRL|SHIFT', action = act.CloseCurrentTab { confirm = false }, },
  { key = 't', mods = 'CTRL|SHIFT', action = act.SpawnTab('CurrentPaneDomain'), },
  { key = 'p', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(-1), },
  { key = 'n', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(1), },
  { key = 'q', mods = 'CTRL|SHIFT', action = act.CloseCurrentPane { confirm = false }, },
  { key = 'h', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Left', },
  { key = 'l', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Right', },
  { key = 'k', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Up', },
  { key = 'j', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Down', },
  { key = '%', mods = 'CTRL|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
  { key = '"', mods = 'CTRL|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' }, },
  { key = 'UpArrow', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Up', 1 }, },
  { key = 'DownArrow', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Down', 1 }, },
  { key = 'LeftArrow', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Left', 1 }, },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Right', 1 }, },
  { key = 'E', mods = 'CTRL|SHIFT', action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
}

-- bypass_mouse_reporting_modifiers = 'SHIFT',
Config.mouse_bindings = {
  -- Change the default click behavior so that it only selects
  -- text and doesn't open hyperlinks
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = act.CompleteSelection 'ClipboardAndPrimarySelection',
  },
  -- and make CTRL-Click open hyperlinks
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = act.OpenLinkAtMouseCursor,
  },
}

return Config
