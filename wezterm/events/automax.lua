local wezterm = require 'wezterm';
local mux = wezterm.mux;

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)
