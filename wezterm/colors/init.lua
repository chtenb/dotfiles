local home = os.getenv("USERPROFILE")  -- Windows
if not home then
    home = os.getenv("HOME")  -- Unix-like systems
end
local scriptPath = home .. "/dotfiles/neo-ansi/terms/wezterm/generated/"
package.path = package.path .. ";" .. scriptPath .. "?.lua"

return {
  ["kanagawa-wave"] = require "colors.kanagawa-wave",
  ["kanagawa-dragon"] = require "colors.kanagawa-dragon",
  ["kanagawa-lotus"] = require "colors.kanagawa-lotus",
  ["lux-neo-ansi"] = require "lux-neo-ansi",
  ["synthwave-material-neo-ansi"] = require "synthwave-material-neo-ansi",
}

