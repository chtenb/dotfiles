local home = os.getenv("USERPROFILE")  -- Windows
if not home then
    home = os.getenv("HOME")  -- Unix-like systems
end
local scriptPath = home .. "/dotfiles/neo-ansi/terms/wezterm/generated/"
package.path = package.path .. ";" .. scriptPath .. "?.lua"

return {
  ["lux-neo-ansi"] = require "lux-neo-ansi",
  ["synthwave-material-neo-ansi"] = require "synthwave-material-neo-ansi",
  ["classic-neo-ansi"] = require "classic-neo-ansi",
}

