local wezterm = require 'wezterm';

-- Name of current coloring for administration purposes
local current_scheme = "None";

local light_colors = {
    -- The default text color
    foreground = "#005661",
    -- The default background color
    background = "#fef8ec",

    -- Overrides the cell background color when the current cell is occupied by the
    -- cursor and the cursor style is set to Block
    -- cursor_bg = "#52ad70",
    -- Overrides the text color when the current cell is occupied by the cursor
    -- cursor_fg = "black",
    -- Specifies the border color of the cursor when the cursor style is set to Block,
    -- or the color of the vertical or horizontal bar when the cursor style is set to
    -- Bar or Underline.
    -- cursor_border = "#52ad70",

    -- the foreground color of selected text
    selection_fg = "#005661",
    -- the background color of selected text
    selection_bg = "#cfe7f0",

    -- The color of the scrollbar "thumb"; the portion that represents the current viewport
    scrollbar_thumb = "#aaa",

    -- The color of the split lines between panes
    split = "#aaa",

    ansi = {"#8ca6a6", "#e64100", "#00b368", "#fa8900", "#0095a8", "#ff5792", "#00bdd6", "#005661"},
    brights = {"#8ca6a6", "#e5164a", "#00b368", "#b3694d", "#0094f0", "#ff5792", "#00bdd6", "#004d57"},

    indexed = {
        [52] = "#fbdada", -- minus
        [88] = "#f6b6b6", -- minus emph
        [22] = "#d6ffd6", -- plus
        [28] = "#adffad", -- plus emph
        [53] = "#feecf7", -- purple
        [17] = "#e5dff6", -- blue
        [23] = "#d8fdf6", -- cyan
        [58] = "#f4ffe0", -- yellow
    },

    -- Since: 20220319-142410-0fcdea07
    -- When the IME, a dead key or a leader key are being processed and are effectively
    -- holding input pending the result of input composition, change the cursor
    -- to this color to give a visual cue about the compose state.
    compose_cursor = "orange",
}


local dark_colors = {
    -- The default text color
    foreground = "#cccccc",
    -- The default background color
    background = "#262335",

    -- Overrides the cell background color when the current cell is occupied by the
    -- cursor and the cursor style is set to Block
    -- cursor_bg = "#52ad70",
    -- Overrides the text color when the current cell is occupied by the cursor
    -- cursor_fg = "black",
    -- Specifies the border color of the cursor when the cursor style is set to Block,
    -- or the color of the vertical or horizontal bar when the cursor style is set to
    -- Bar or Underline.
    -- cursor_border = "#52ad70",

    -- the foreground color of selected text
    selection_fg = "#cccccc",
    -- the background color of selected text
    selection_bg = "#333041",

    -- The color of the scrollbar "thumb"; the portion that represents the current viewport
    scrollbar_thumb = "#aaa",

    -- The color of the split lines between panes
    split = "#aaa",

    ansi = {'#676e95' ,'#f07178' ,'#c3e88d' ,'#ffcb6b' ,'#94afeb' ,'#c792ea' ,'#b9dedf' ,'#b4b8d0'},
    brights = {'#676e95' ,'#ff5370' ,'#87de97' ,'#f78c6c' ,'#b9dedf' ,'#c792ea' ,'#91f5f8' ,'#dddddd'},

    indexed = {
        [52] = "#330f0f", -- minus
        [88] = "#4f1917", -- minus emph
        [22] = "#0e2f19", -- plus
        [28] = "#174525", -- plus emph
        [53] = "#330f29", -- purple
        [17] = "#271344", -- blue
        [23] = "#0d3531", -- cyan
        [58] = "#222f14", -- yellow
    },

    -- Since: 20220319-142410-0fcdea07
    -- When the IME, a dead key or a leader key are being processed and are effectively
    -- holding input pending the result of input composition, change the cursor
    -- to this color to give a visual cue about the compose state.
    compose_cursor = "orange",
}


wezterm.on("window-config-reloaded", function(window, pane)
    local overrides = window:get_config_overrides() or {}
    local appearance = window:get_appearance()

    local name = "Light"
    local colors = light_colors
    if appearance:find("Dark") then
        name = "Dark"
        colors = dark_colors
    end

    if current_scheme ~= name then
        overrides.colors = colors;
        window:set_config_overrides(overrides)
    end
end)


return {
    window_close_confirmation = "NeverPrompt",
    hide_tab_bar_if_only_one_tab = true,

    font = wezterm.font_with_fallback({"Cascadia Code", "Cascadia Code,FiraCode Nerd Font"}),
    -- You can specify some parameters to influence the font selection;
    -- for example, this selects a Bold, Italic font variant.
    -- font = wezterm.font("JetBrains Mono", {weight="Bold", italic=true})
    font_size = 10.0,
}
