local wez = require 'wezterm';

wez.on('window-config-reloaded', function(window, pane)
  wez.log_info("Handling window-config-reloaded")

  local name = 'Lux (neo-ansi)'
  local appearance = window:get_appearance()
  if appearance:find('Dark') then
    name = 'Synthwave Material (neo-ansi)'
  end


  local overrides = window:get_config_overrides() or {}
  overrides.color_scheme = name

  overrides.colors = {
    indexed = {
      -- [244] = 'blue',
    }
  }

  -- if overrides.color_scheme ~= name then
  --   overrides.color_scheme = name;
  --   window:set_config_overrides(overrides)
  -- end

  window:set_config_overrides(overrides)
end)
