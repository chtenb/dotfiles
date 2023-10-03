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
  keys = {
    {
      key = 'q',
      mods = 'CTRL|ALT',
      action = act.CloseCurrentTab { confirm = false },
    },
    {
      key = 't',
      mods = 'CTRL|ALT',
      action = act.SpawnTab('CurrentPaneDomain'),
    },
    {
      key = 'p',
      mods = 'CTRL|ALT',
      action = act.ActivateTabRelative(-1),
    },
    {
      key = 'n',
      mods = 'CTRL|ALT',
      action = act.ActivateTabRelative(1),
    },
    {
      key = 'q',
      mods = 'SHIFT|ALT',
      action = act.CloseCurrentPane { confirm = false },
    },
    {
      key = 'h',
      mods = 'SHIFT|ALT',
      action = act.ActivatePaneDirection 'Left',
    },
    {
      key = 'l',
      mods = 'SHIFT|ALT',
      action = act.ActivatePaneDirection 'Right',
    },
    {
      key = 'k',
      mods = 'SHIFT|ALT',
      action = act.ActivatePaneDirection 'Up',
    },
    {
      key = 'j',
      mods = 'SHIFT|ALT',
      action = act.ActivatePaneDirection 'Down',
    },
    {
      key = '%',
      mods = 'SHIFT|ALT',
      action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = '"',
      mods = 'SHIFT|ALT',
      action = act.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'UpArrow',
      mods = 'SHIFT|ALT',
      action = act.AdjustPaneSize { 'Up', 1 },
    },
    {
      key = 'DownArrow',
      mods = 'SHIFT|ALT',
      action = act.AdjustPaneSize { 'Down', 1 },
    },
    {
      key = 'LeftArrow',
      mods = 'SHIFT|ALT',
      action = act.AdjustPaneSize { 'Left', 1 },
    },
    {
      key = 'RightArrow',
      mods = 'SHIFT|ALT',
      action = act.AdjustPaneSize { 'Right', 1 },
    },
  },
  mouse_bindings = {
    -- Bind 'Up' event of CTRL-Click to open hyperlinks
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = act.OpenLinkAtMouseCursor,
    },
    -- Disable the 'Down' event of CTRL-Click to avoid weird program behaviors
    {
      event = { Down = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = act.Nop,
    },
  }
}
