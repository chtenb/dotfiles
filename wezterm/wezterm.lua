local wez = require "wezterm" ---@class WezTerm
local fun = require "utils.fun"

require "events.update-status"
require "events.format-tab-title"
require "events.new-tab-button-click"
require "events.lock-interface"
require "events.augment-command-palette"

require 'events.window-config-reloaded'
require 'events.automax'

wez.log_info("get_appearance (from wezterm):")
wez.log_info(wez.gui.get_appearance())

local Config = fun.tbl_merge(
  (require "config").get_config(),
  (require "mappings")
)

return Config

