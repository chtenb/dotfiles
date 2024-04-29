local wezterm = require 'wezterm';

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
