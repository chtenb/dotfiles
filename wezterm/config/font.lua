---@class WezTerm
local wezterm = require "wezterm"

-- === <= |> =>
local monaspace_features = { 'calt=1', 'ss01=1', 'ss02=0', 'ss03=1', 'ss04=1', 'ss05=1', 'ss06=1', 'ss07=1', 'ss08=1', 'ss09=0', 'liga=1'
  , 'cv01=0' -- zero styles
  , 'cv10=0' -- l i alternates (Neon, Argon, Xenon, Radon)
  , 'cv11=0' -- j f r t alternates (Neon, Argon)
  , 'cv60=0' -- forces the <= pair to render in a fashion that matches => instead of swapping for ≤.
  }
-- local monaspace_features = { 'calt=1', 'ss01=1', 'ss02=0', 'ss03=1', 'ss04=1', 'ss05=1', 'ss06=1', 'ss07=1', 'ss08=1', 'ss09=1', 'liga=1' }

---@class Config
local Config = {
  font_size = 10.0,

  -- NOTE: use fixed otf fonts instead of variable ttf fonts. The latter just don't seem to work properly on wezterm.
  -- Only installing Italic and Regular seems to work
  font = wezterm.font_with_fallback {
    {
      family = 'Monaspace Neon',
      -- weight = 600,
      weight = 'Regular',
      harfbuzz_features = monaspace_features,
      -- family = 'Cascadia Code',
    },
    {
      family = 'Cambria Math',
      -- weight = 'Medium',
      harfbuzz_features = monaspace_features,
    },
    {
      family = 'Segoe UI Symbol',
      -- weight = 'Medium',
      harfbuzz_features = monaspace_features,
    },
  },
  font_rules = {
    {
      intensity = 'Bold',
      italic = false,
      font = wezterm.font {
        family = 'Monaspace Neon',
        weight = 'Bold',
        harfbuzz_features = monaspace_features,
      }
    },
    {
      intensity = 'Normal',
      italic = true,
      font = wezterm.font {
        family = 'Monaspace Neon',
        weight = 'Regular',
        style = 'Italic',
        harfbuzz_features = monaspace_features,
      }
    },
    {
      intensity = 'Bold',
      italic = true,
      font = wezterm.font {
        family = 'Monaspace Krypton',
        weight = 'Bold',
        style = 'Normal',
        harfbuzz_features = monaspace_features,
      }
    },
    {
      intensity = 'Half',
      font = wezterm.font {
        family = 'Monaspace Argon',
        weight = 'Medium',
        style = 'Normal',
        harfbuzz_features = monaspace_features,
      }
    },
  },
}

return Config
