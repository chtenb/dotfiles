require "events.update-status"
require "events.format-tab-title"
require "events.new-tab-button-click"
require "events.lock-interface"
require "events.augment-command-palette"

require 'events.autodark'
require 'events.automax'

local Config = require("utils.config"):new():add("config"):add "mappings"

-- Config.colors = {
--   indexed = {
--     [232] = 'red',
--   }
-- }
return Config
