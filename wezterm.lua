local wezterm = require 'wezterm';

function scheme_for_appearance(appearance)
    if appearance:find("Dark") then
        return "Builtin Solarized Dark"
    else
        return "Builtin Solarized Light"
    end
end

wezterm.on("window-config-reloaded", function(window, pane)
    local overrides = window:get_config_overrides() or {}
    local appearance = window:get_appearance()
    local scheme = scheme_for_appearance(appearance)
    if overrides.color_scheme ~= scheme then
        overrides.color_scheme = scheme
        window:set_config_overrides(overrides)
    end
end)

return {
    font = wezterm.font_with_fallback({"Cascadia Code", "Cascadia Code,FiraCode Nerd Font"}),
    -- You can specify some parameters to influence the font selection;
    -- for example, this selects a Bold, Italic font variant.
    -- font = wezterm.font("JetBrains Mono", {weight="Bold", italic=true})
    font_size = 10.0,
    use_fancy_tab_bar = false,

    -- window_decorations = "RESIZE",
    window_frame = {
        -- The font used in the tab bar.
        -- Roboto Bold is the default; this font is bundled
        -- with wezterm.
        -- Whatever font is selected here, it will have the
        -- main font setting appended to it to pick up any
        -- fallback fonts you may have used there.
        font = wezterm.font({
            family = "Roboto",
            weight = "Bold"
        }),

        -- The size of the font in the tab bar.
        -- Default to 10. on Windows but 12.0 on other systems
        font_size = 12.0,

        -- The overall background color of the tab bar when
        -- the window is focused
        active_titlebar_bg = "#333333",

        -- The overall background color of the tab bar when
        -- the window is not focused
        inactive_titlebar_bg = "#333333"
    },

    colors = {
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
        selection_bg = "#dddacd",

        -- The color of the scrollbar "thumb"; the portion that represents the current viewport
        scrollbar_thumb = "#aaa",

        -- The color of the split lines between panes
        split = "#aaa",

        ansi = {"#8ca6a6", "#e64100", "#00b368", "#fa8900", "#0095a8", "#ff5792", "#00bdd6", "#005661"},
        brights = {"#8ca6a6", "#e5164a", "#00b368", "#b3694d", "#0094f0", "#ff5792", "#00bdd6", "#004d57"},

        -- Arbitrary colors of the palette in the range from 16 to 255
        indexed = {
            [136] = "#af8700"
        },

        -- Since: 20220319-142410-0fcdea07
        -- When the IME, a dead key or a leader key are being processed and are effectively
        -- holding input pending the result of input composition, change the cursor
        -- to this color to give a visual cue about the compose state.
        compose_cursor = "orange",

        tab_bar = {
            -- The color of the strip that goes along the top of the window
            -- (does not apply when fancy tab bar is in use)
            background = "#0b0022",

            -- The active tab is the one that has focus in the window
            active_tab = {
                -- The color of the background area for the tab
                bg_color = "#2b2042",
                -- The color of the text for the tab
                fg_color = "#c0c0c0",

                -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
                -- label shown for this tab.
                -- The default is "Normal"
                intensity = "Normal",

                -- Specify whether you want "None", "Single" or "Double" underline for
                -- label shown for this tab.
                -- The default is "None"
                underline = "None",

                -- Specify whether you want the text to be italic (true) or not (false)
                -- for this tab.  The default is false.
                italic = false,

                -- Specify whether you want the text to be rendered with strikethrough (true)
                -- or not for this tab.  The default is false.
                strikethrough = false
            },

            -- Inactive tabs are the tabs that do not have focus
            inactive_tab = {
                bg_color = "#1b1032",
                fg_color = "#808080"

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `inactive_tab`.
            },

            -- You can configure some alternate styling when the mouse pointer
            -- moves over inactive tabs
            inactive_tab_hover = {
                bg_color = "#3b3052",
                fg_color = "#909090",
                italic = true

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `inactive_tab_hover`.
            },

            -- The new tab button that let you create new tabs
            new_tab = {
                bg_color = "#1b1032",
                fg_color = "#808080"

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `new_tab`.
            },

            -- You can configure some alternate styling when the mouse pointer
            -- moves over the new tab button
            new_tab_hover = {
                bg_color = "#3b3052",
                fg_color = "#909090",
                italic = true

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `new_tab_hover`.
            }
        }
    }
}
