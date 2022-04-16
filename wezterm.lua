local wezterm = require 'wezterm';

wezterm.on("window-config-reloaded", function(window, pane)
    local name = "Noctis Lux Ansi 16"
    local appearance = window:get_appearance()
    if appearance:find("Dark") then
        name = "Synthwave Material Ansi 16"
    end

    local overrides = window:get_config_overrides() or {}
    if overrides.color_scheme ~= name then
        overrides.color_scheme = name;
        window:set_config_overrides(overrides)
    end
end)


return {
    color_scheme_dirs = {"C:\\users\\chiel.tenbrinke\\dotfiles\\wezterm-color-schemes"},
    window_close_confirmation = "NeverPrompt",
    hide_tab_bar_if_only_one_tab = true,

    font = wezterm.font_with_fallback({"Cascadia Code", "Cascadia Code,FiraCode Nerd Font"}),
    -- You can specify some parameters to influence the font selection;
    -- for example, this selects a Bold, Italic font variant.
    -- font = wezterm.font("JetBrains Mono", {weight="Bold", italic=true})
    font_size = 10.0,
}
