local wezterm = require 'wezterm';
local mux = wezterm.mux;
local act = wezterm.action;

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

wezterm.on('window-config-reloaded', function(window, pane)
  local name = 'Noctis Lux (Neo Ansi)'
  local appearance = window:get_appearance()
  if appearance:find('Dark') then
    name = 'Synthwave Material (Neo Ansi)'
  end

  local overrides = window:get_config_overrides() or {}
  if overrides.color_scheme ~= name then
    overrides.color_scheme = name;
    window:set_config_overrides(overrides)
  end
end)


return {
  color_scheme_dirs = { 'C:\\users\\chiel.tenbrinke\\dotfiles\\wezterm-color-schemes' },
  default_prog = { 'nu' },
  window_close_confirmation = 'NeverPrompt',
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  -- allow_win32_input_mode = false,

  -- For connecting to a unix pty
  -- https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
  unix_domains = { { name = 'unix', local_echo_threshold_ms = 10, }, },

  font = wezterm.font_with_fallback({ 'Cascadia Code', 'Cascadia Code,CaskaydiaCove NF' }),
  -- You can specify some parameters to influence the font selection;
  -- for example, this selects a Bold, Italic font variant.
  -- font = wezterm.font('JetBrains Mono', {weight='Bold', italic=true})
  font_size = 10.0,
  bypass_mouse_reporting_modifiers = 'CTRL',
  keys = {
   {
      key = '?',
      mods = 'CTRL|SHIFT',
      action = act.ActivateCommandPalette,
    },
    {
      key = 'q',
      mods = 'CTRL|SHIFT',
      action = act.CloseCurrentTab { confirm = false },
    },
    {
      key = 't',
      mods = 'CTRL|SHIFT',
      action = act.SpawnTab('CurrentPaneDomain'),
    },
    {
      key = 'p',
      mods = 'CTRL|SHIFT',
      action = act.ActivateTabRelative(-1),
    },
    {
      key = 'n',
      mods = 'CTRL|SHIFT',
      action = act.ActivateTabRelative(1),
    },
    {
      key = 'q',
      mods = 'CTRL|SHIFT',
      action = act.CloseCurrentPane { confirm = false },
    },
    {
      key = 'h',
      mods = 'CTRL|SHIFT',
      action = act.ActivatePaneDirection 'Left',
    },
    {
      key = 'l',
      mods = 'CTRL|SHIFT',
      action = act.ActivatePaneDirection 'Right',
    },
    {
      key = 'k',
      mods = 'CTRL|SHIFT',
      action = act.ActivatePaneDirection 'Up',
    },
    {
      key = 'j',
      mods = 'CTRL|SHIFT',
      action = act.ActivatePaneDirection 'Down',
    },
    {
      key = '%',
      mods = 'CTRL|SHIFT',
      action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = '"',
      mods = 'CTRL|SHIFT',
      action = act.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'UpArrow',
      mods = 'CTRL|SHIFT',
      action = act.AdjustPaneSize { 'Up', 1 },
    },
    {
      key = 'DownArrow',
      mods = 'CTRL|SHIFT',
      action = act.AdjustPaneSize { 'Down', 1 },
    },
    {
      key = 'LeftArrow',
      mods = 'CTRL|SHIFT',
      action = act.AdjustPaneSize { 'Left', 1 },
    },
    {
      key = 'RightArrow',
      mods = 'CTRL|SHIFT',
      action = act.AdjustPaneSize { 'Right', 1 },
    },
    {
      key = 'E',
      mods = 'CTRL|SHIFT',
      action = act.PromptInputLine {
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
  },
}
