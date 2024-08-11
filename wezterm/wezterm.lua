require "events.update-status"
require "events.format-tab-title"
require "events.new-tab-button-click"
require "events.lock-interface"
require "events.augment-command-palette"

require 'events.window-config-reloaded'
require 'events.automax'

local Config = require("utils.config"):new():add("config"):add "mappings"
local wez = require "wezterm" ---@class WezTerm
wez.log_info("get_appearance (from wezterm):")
wez.log_info(wez.gui.get_appearance())

-- Config.colors = {
--   indexed = {
--     [232] = 'red',
--   }
-- }
return Config
