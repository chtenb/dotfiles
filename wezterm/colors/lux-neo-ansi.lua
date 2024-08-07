return {
  foreground = "#005661",
  background = "#fefaf2", -- rgb(254.99, 249.55, 238.67)
  cursor_bg = "#005661",
  cursor_border = "#005661",
  cursor_fg = "#ffffff",
  selection_bg = "#cfe7f0",
  selection_fg = "#005661",

  ansi = {
    "#8ca6a6", -- black
    "#e64100", -- red
    "#24a342", -- green
    "#e47d00", -- yellow
    "#0095a8", -- blue
    "#ff5792", -- magenta
    "#00bdd6", -- cyan
    "#005661" }, -- white

  brights = {
    "#8ca6a6", -- bright black
    "#e5164a", -- bright red
    "#00b368", -- bright green
    "#b3694d", -- bright yellow
    "#0094f0", -- bright blue
    "#ff5792", -- bright magenta
    "#00bdd6", -- bright cyan
    "#004d57" }, -- bright white

  indexed = {
    -- background colors for git diffs
    [52] = "#fbdada", -- red
    [88] = "#f6b6b6", -- red emph
    [22] = "#d6ffd6", -- green
    [28] = "#adffad", -- green emph
    [53] = "#feecf7", -- purple
    [17] = "#e5dff6", -- blue
    [23] = "#d8fdf6", -- cyan
    [58] = "#f4ffe0", -- yellow

    -- Colors 232-255 are general UI colors
    -- Background color idea:
    --f8f1e0
    --f9efdc
    --faedd8
    --faebd4
    --fbe8d0
    --fce6cc
    --fce4c8
    --fde2c4

    -- bg - all base colors must be readable against these
    [232] = "#f8f1e0", -- e8 bg 01: background #1 inactive background
    [233] = "#f1e7c9", -- e9 bg 02: background #2 inactive overlay background
    [234] = "#efe9d5", -- ea bg 03: background #3 overlay background
    [235] = "#f1e7c9", -- eb bg 04: background #4 inactive overlay title bar
    [236] = "#e3ded3", -- ec bg 05: alt background #1 overlay title bar
    [237] = "#efebdf", -- ed bg 06: alt background #2 inactive main title bar
    [238] = "#efe9d5", -- ee bg 07: alt background #3 main title bar
    [239] = "#d8eef1", -- ef bg 08: alt background #4 special highlight
    [240] = "#daedeb", -- f0 bg 09: selection #1 inactive selection
    [241] = "#d8eef1", -- f1 bg 10: selection #2 active selection
    [242] = "#d6f3fa", -- f2 bg 11: selection #3 inactive primary selection
    [243] = "#d6f3fa", -- f3 bg 12: selection #4 active primary selection
    -- fg - the default foreground color must be readable against these in inverse mode
    [244] = "#8ca6a6", -- f4 fg 01: Inactive inverse fg
    [245] = "#efe9d5", -- f5 fg 02: Soft inverse fg
    [246] = "#fefaf2", -- f6 fg 03: Regular inverse fg
    [247] = "#ffffff", -- f7 fg 04: Highlighted inverse fg
    [248] = "#58868a", -- f8 fg 05:
    [249] = "#4b7e83", -- f9 fg 06:
    [250] = "#3e767c", -- fa fg 07:
    [251] = "#316e75", -- fb fg 08:
    [252] = "#24666e", -- fc fg 09:
    [253] = "#175e67", -- fd fg 10:
    [254] = "#0a5660", -- fe fg 11:
    [255] = "#004d57", -- ff fg 12: active text

    -- UI variants of base text colors (No readability requirement, optimize for looks)
    [226] = "#fa8900", -- Yellow; warning
  },

  tab_bar = {
    background = "#efe9d5",
    inactive_tab_edge = "#efe9d5",
    inactive_tab_edge_hover = "#efe9d5",

    active_tab = {
      bg_color = "#fdf8eb",
      fg_color = "#3E767C",
      -- italic = false,
      -- strikethrough = false,
      -- underline = "None",
      -- intensity = "Normal",
    },

    inactive_tab = {
      bg_color = "#efe9d5",
      fg_color = "#8ca6a6",
    },

    inactive_tab_hover = {
      bg_color = "#d6dfd0",
      fg_color = "#8ca6a6",
    },

    new_tab = {
      bg_color = "#efe9d5",
      fg_color = "#8ca6a6",
    },

    new_tab_hover = {
      bg_color = "#efe9d5",
      fg_color = "#3299ae",
      intensity = "Bold",
    }
  }
}
