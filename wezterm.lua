local wezterm = require 'wezterm';
local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

wezterm.on('window-config-reloaded', function(window, pane)
    local name = 'Noctis Lux'
--    local appearance = window:get_appearance()
--    if appearance:find('Dark') then
--        name = 'Synthwave Material'
--    end

    local overrides = window:get_config_overrides() or {}
    if overrides.color_scheme ~= name then
        overrides.color_scheme = name;
        window:set_config_overrides(overrides)
    end
end)


return {
    color_scheme_dirs = {'C:\\users\\chiel.tenbrinke\\dotfiles\\wezterm-color-schemes'},
    default_prog = { 'nu' },
    window_close_confirmation = 'NeverPrompt',
    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = false,
    tab_bar_at_bottom = true,

    font = wezterm.font_with_fallback({'Cascadia Code', 'Cascadia Code,CaskaydiaCove NF'}),
    -- You can specify some parameters to influence the font selection;
    -- for example, this selects a Bold, Italic font variant.
    -- font = wezterm.font('JetBrains Mono', {weight='Bold', italic=true})
    font_size = 10.0,
    keys = {
        {
          key = 'q',
          mods = 'CTRL|ALT',
          action = wezterm.action.CloseCurrentTab{confirm=false},
        },
        {
          key = 't',
          mods = 'CTRL|ALT',
          action = wezterm.action.SpawnTab('CurrentPaneDomain'),
        },
        {
          key = 'h',
          mods = 'CTRL|ALT',
          action = wezterm.action.ActivateTabRelative(-1),
        },
        {
          key = 'l',
          mods = 'CTRL|ALT',
          action = wezterm.action.ActivateTabRelative(1),
        },
        {
          key = 'q',
          mods = 'SHIFT|ALT',
          action = wezterm.action.CloseCurrentPane{confirm=false},
        },
        {
          key = 'h',
          mods = 'SHIFT|ALT',
          action = wezterm.action.ActivatePaneDirection 'Left',
        },
        {
          key = 'l',
          mods = 'SHIFT|ALT',
          action = wezterm.action.ActivatePaneDirection 'Right',
        },
        {
          key = 'k',
          mods = 'SHIFT|ALT',
          action = wezterm.action.ActivatePaneDirection 'Up',
        },
        {
          key = 'j',
          mods = 'SHIFT|ALT',
          action = wezterm.action.ActivatePaneDirection 'Down',
        },
        {
          key = '%',
          mods = 'SHIFT|ALT',
          action = wezterm.action.SplitHorizontal{ domain = 'CurrentPaneDomain' },
        },
        {
          key = '"',
          mods = 'SHIFT|ALT',
          action = wezterm.action.SplitVertical{ domain = 'CurrentPaneDomain' },
        },
        {
          key = 'UpArrow',
          mods = 'SHIFT|ALT',
          action = wezterm.action.AdjustPaneSize{ 'Up', 1 },
        },
        {
          key = 'DownArrow',
          mods = 'SHIFT|ALT',
          action = wezterm.action.AdjustPaneSize{ 'Down', 1 },
        },
        {
          key = 'LeftArrow',
          mods = 'SHIFT|ALT',
          action = wezterm.action.AdjustPaneSize{ 'Left', 1 },
        },
        {
          key = 'RightArrow',
          mods = 'SHIFT|ALT',
          action = wezterm.action.AdjustPaneSize{ 'Right', 1 },
        },
    }
}
