local wezterm = require 'wezterm';
local mux = wezterm.mux;
local act = wezterm.action;

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

require 'autodark'

-- === <= |> =>
local monaspace_features = { 'calt=1', 'ss01=1', 'ss02=0', 'ss03=1', 'ss04=1', 'ss05=1', 'ss06=1', 'ss07=1', 'ss08=1', 'liga=1', 'cv60=1' }

local config = {
  color_scheme_dirs = {
    'C:\\users\\chiel.tenbrinke\\dotfiles\\neo-ansi\\terms\\wezterm',
    'C:\\users\\chiel.tenbrinke\\dotfiles\\wezterm\\color-schemes',
   },
  default_prog = { 'nu' },
  window_close_confirmation = 'AlwaysPrompt',
  skip_close_confirmation_for_processes_named = {
    "bash.exe",
    "nu.exe",
    "cmd.exe",
    "pwsh.exe",
    "powershell.exe",
    "broot.exe",
  },
  clean_exit_codes = { 130 },
  exit_behavior_messaging = "Verbose",
  exit_behavior = "CloseOnCleanExit",

  hide_tab_bar_if_only_one_tab = false,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  enable_kitty_graphics=true,
  allow_win32_input_mode = true,

  -- font = wezterm.font_with_fallback({ 'Cascadia Code', 'Cascadia Code,CaskaydiaCove NF'}),
  font_size = 10.0,

  font = wezterm.font_with_fallback {
    {
      family = 'Monaspace Neon',
      weight = 'Medium',
      harfbuzz_features = monaspace_features,
    },
    {
      family = 'Cambria Math',
      weight = 'Medium',
      harfbuzz_features = monaspace_features,
    },
    {
      family = 'Segoe UI Symbol',
      weight = 'Medium',
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
        weight = 'Regular',
        style = 'Normal',
        harfbuzz_features = monaspace_features,
      }
    },
  },

  inactive_pane_hsb = {
    saturation = 0.8,
    brightness = 0.9,
  },
  -- bypass_mouse_reporting_modifiers = 'SHIFT',
  mouse_bindings = {
    -- Change the default click behavior so that it only selects
    -- text and doesn't open hyperlinks
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'NONE',
      action = act.CompleteSelection 'ClipboardAndPrimarySelection',
    },
    -- and make CTRL-Click open hyperlinks
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = act.OpenLinkAtMouseCursor,
    },
  },
  keys = {
    {
      key = '?',
      mods = 'CTRL|SHIFT',
      action = act.ActivateCommandPalette,
    },
    {
      key = 'q',
      mods = 'CTRL|SHIFT',
      action = act.CloseCurrentTab { confirm = false },
    },
    {
      key = 't',
      mods = 'CTRL|SHIFT',
      action = act.SpawnTab('CurrentPaneDomain'),
    },
    {
      key = 'p',
      mods = 'CTRL|SHIFT',
      action = act.ActivateTabRelative(-1),
    },
    {
      key = 'n',
      mods = 'CTRL|SHIFT',
      action = act.ActivateTabRelative(1),
    },
    {
      key = 'q',
      mods = 'CTRL|SHIFT',
      action = act.CloseCurrentPane { confirm = false },
    },
    {
      key = 'h',
      mods = 'CTRL|SHIFT',
      action = act.ActivatePaneDirection 'Left',
    },
    {
      key = 'l',
      mods = 'CTRL|SHIFT',
      action = act.ActivatePaneDirection 'Right',
    },
    {
      key = 'k',
      mods = 'CTRL|SHIFT',
      action = act.ActivatePaneDirection 'Up',
    },
    {
      key = 'j',
      mods = 'CTRL|SHIFT',
      action = act.ActivatePaneDirection 'Down',
    },
    {
      key = '%',
      mods = 'CTRL|SHIFT',
      action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = '"',
      mods = 'CTRL|SHIFT',
      action = act.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'UpArrow',
      mods = 'CTRL|SHIFT',
      action = act.AdjustPaneSize { 'Up', 1 },
    },
    {
      key = 'DownArrow',
      mods = 'CTRL|SHIFT',
      action = act.AdjustPaneSize { 'Down', 1 },
    },
    {
      key = 'LeftArrow',
      mods = 'CTRL|SHIFT',
      action = act.AdjustPaneSize { 'Left', 1 },
    },
    {
      key = 'RightArrow',
      mods = 'CTRL|SHIFT',
      action = act.AdjustPaneSize { 'Right', 1 },
    },
    {
      key = 'E',
      mods = 'CTRL|SHIFT',
      action = act.PromptInputLine {
        description = 'Enter new name for tab',
        action = wezterm.action_callback(function(window, pane, line)
          -- line will be `nil` if they hit escape without entering anything
          -- An empty string if they just hit enter
          -- Or the actual line of text they wrote
          if line then
            window:active_tab():set_title(line)
          end
        end),
      },
    },
  },
}

config.unix_domains = {
  {
    name = 'wsl',
    serve_command = { 'wsl', 'wezterm-mux-server', '--daemonize' },
  },
}

  -- -- For connecting to a unix pty
  -- -- https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
  -- unix_domains = { { name = 'unix', local_echo_threshold_ms = 10, }, },


-- Run
--   wezterm connect wsl
-- to connect to wsl
return config
