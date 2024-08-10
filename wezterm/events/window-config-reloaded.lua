local wez = require 'wezterm';

wez.on('window-config-reloaded', function(window, pane)
  wez.log_info("window-config-reloaded")
end)
