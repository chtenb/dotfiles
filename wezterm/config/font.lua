---@class WezTerm
local wezterm = require "wezterm"

-- === <= |> =>
local monaspace_features = { 'calt=1', 'ss01=1', 'ss02=0', 'ss03=1', 'ss04=1', 'ss05=1', 'ss06=1', 'ss07=1', 'ss08=1', 'ss09=0', 'liga=1'
  , 'cv01=0' -- zero styles
  , 'cv10=0' -- l i alternates (Neon, Argon, Xenon, Radon)
  , 'cv11=0' -- j f r t alternates (Neon, Argon)
  , 'cv60=0' -- forces the <= pair to render in a fashion that matches => instead of swapping for ≤.
  }

local MonaspaceConfig = {
  font_size = 10.0,

  -- NOTE: use fixed otf fonts instead of variable ttf fonts. The latter just don't seem to work properly on wezterm.
  -- Only installing Italic and Regular seems to work
  font = wezterm.font_with_fallback {
    {
      family = 'monaspace neon',
      -- weight = 600,
      weight = 'regular',
      harfbuzz_features = monaspace_features,
    },
    {
      family = 'cambria math',
      -- weight = 'medium',
      harfbuzz_features = monaspace_features,
    },
    {
      family = 'segoe ui symbol',
      -- weight = 'medium',
      harfbuzz_features = monaspace_features,
    },
  },
  font = wezterm.font 'Iosevka Term Slab',
  font_rules = {
    {
      intensity = 'bold',
      italic = false,
      font = wezterm.font {
        family = 'monaspace neon',
        weight = 'bold',
        harfbuzz_features = monaspace_features,
      }
    },
    {
      intensity = 'normal',
      italic = true,
      font = wezterm.font {
        family = 'monaspace neon',
        weight = 'regular',
        style = 'italic',
        harfbuzz_features = monaspace_features,
      }
    },
    {
      intensity = 'bold',
      italic = true,
      font = wezterm.font {
        family = 'monaspace krypton',
        weight = 'bold',
        style = 'normal',
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

local IosevkaConfig = {
  font_size = 10.0,
  -- font = wezterm.font 'Iosevka',
  -- font = wezterm.font 'Iosevka Term',
  -- font = wezterm.font 'Iosevka Slab',
  font = wezterm.font 'Iosevka Term Slab',
  font_rules = {
    {
      intensity = 'Half',
      font = wezterm.font {
        family = 'Iosevka Term Slab',
        weight = 'Medium',
        style = 'Italic',
      }
    },
  },
}

return IosevkaConfig
