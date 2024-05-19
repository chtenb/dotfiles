---@class Layout
local Layout = {}

---Creates a new instance of the Layout class.
---@return Layout instance newly created class instance.
function Layout:new()
  return setmetatable({ layout = {} }, { __index = self })
end

---Add elements to the layout table.
---
---the following attributes are supported:
---
---```lua
---local attributes = {
---  NoUnderline = { Underline = "None" },
---  Single = { Underline = "Single" },
---  Double = { Underline = "Double" },
---  Curly = { Underline = "Curly" },
---  Dotted = { Underline = "Dotted" },
---  Dashed = { Underline = "Dashed" },
---  Normal = { Intensity = "Normal" },
---  Bold = { Intensity = "Bold" },
---  Half = { Intensity = "Half" },
---  Italic = { Italic = true },
--   NoItalic = { Italic = false },
---}
---```
---@param background? string background color of the cell.
---@param foreground? string foreground color of the cell.
---@param text? string text to be added.
---@param attributes? table list of attributes to be added.
---@return Layout self The updated layout instance.
function Layout:push(background, foreground, text, attributes)
  self = self or {}
  local insert = table.insert

  if attributes == "Reset" then
    insert(self, "ResetAttributes")
  end

  -- Attributes go before the colors, because setting an attribute may override
  -- the manual color escape sequence, for some reason
  local attribute_mappings = {
    NoUnderline = { Underline = "None" },
    Single = { Underline = "Single" },
    Double = { Underline = "Double" },
    Curly = { Underline = "Curly" },
    Dotted = { Underline = "Dotted" },
    Dashed = { Underline = "Dashed" },
    Normal = { Intensity = "Normal" },
    Bold = { Intensity = "Bold" },
    Half = { Intensity = "Half" },
    Italic = { Italic = true },
    NoItalic = { Italic = false },
  }

  if attributes then
    for _, attribute in ipairs(attributes) do
      if attribute_mappings[attribute] then
        insert(self, { Attribute = attribute_mappings[attribute] })
      end
    end
  end

  if (background) then
    if background:match("^#") then
      insert(self, { Background = { Color = background } })
    else
      insert(self, { Text = '\x1b[48:5:' .. background .. ':0m' })
    end
  end
  if (foreground) then
    if foreground:match("^#") then
      insert(self, { Foreground = { Color = foreground } })
    else
      insert(self, { Text = '\x1b[38:5:' .. foreground .. ':0m' })
    end
  end

  if attributes then
    for _, attribute in ipairs(attributes) do
      if attribute == "InverseOn" then
        insert(self, { Text = '\x1b[7m' })
      elseif attribute == "InverseOff" then
        insert(self, { Text = '\x1b[27m' })
      end
    end
  end

  if (text) then
    table.insert(self, { Text = text })
  end

  return self
end

return Layout
