# Nushell Config File

# use ~/dotfiles/nu_scripts/custom-completions/cargo/cargo-completions.nu *
use ~/dotfiles/nu_scripts/custom-completions/git/git-completions.nu *
use ~/dotfiles/nu_scripts/custom-completions/npm/npm-completions.nu *


# for more information on themes see
# https://www.nushell.sh/book/coloring_and_theming.html
let default_theme = {
    # color for nushell primitives
    binary: white
    block: white
    bool: white
    cell-path: white
    date: white
    duration: white
    empty: blue
    filesize: white
    float: white
    header: green_bold
    hints: dark_gray
    int: white
    leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
    list: white
    nothing: white
    range: white
    record: white
    row_index: green_bold
    separator: white
    string: white

    # shapes are used to change the cli syntax highlighting
    search_result: {bg: red fg: white}
    shape_and: purple_bold
    shape_binary: purple_bold
    shape_block: blue_bold
    shape_bool: light_cyan
    shape_closure: green_bold
    shape_custom: green
    shape_datetime: cyan_bold
    shape_directory: cyan
    shape_external: cyan
    shape_external_resolved: light_yellow_bold
    shape_externalarg: green_bold
    shape_filepath: cyan
    shape_flag: blue_bold
    shape_float: purple_bold
    shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
    shape_globpattern: cyan_bold
    shape_int: purple_bold
    shape_internalcall: cyan_bold
    shape_list: cyan_bold
    shape_literal: blue
    shape_match_pattern: green
    shape_matching_brackets: { attr: u }
    shape_nothing: light_cyan
    shape_operator: yellow
    shape_or: purple_bold
    shape_pipe: purple_bold
    shape_range: yellow_bold
    shape_record: cyan_bold
    shape_redirection: purple_bold
    shape_signature: green_bold
    shape_string: green
    shape_string_interpolation: cyan_bold
    shape_table: blue_bold
    shape_vardecl: purple
    shape_variable: purple
}
$env.config = {
  show_banner: false
  color_config: $default_theme
  cursor_shape: {
    emacs: block # block, underscore, line (line is the default)
    vi_insert: block # block, underscore, line (block is the default)
    vi_normal: underscore # block, underscore, line  (underscore is the default)
  }
  completions: {
    quick: false  # set this to false to prevent auto-selecting completions when only one remains
  }
  menus: [
  ]
  keybindings: [
    {
      name: history_hint
      modifier: control
      keycode: tab
      mode: emacs
      event: [ { send: HistoryHintComplete } ]
    }
    {
      name: history_hint_word
      modifier: none
      keycode: tab
      mode: emacs
      event: [ { send: HistoryHintWordComplete } ]
    }
    {
      name: completion_menu
      modifier: control
      keycode: char_n
      mode: emacs # Options: emacs vi_normal vi_insert
      event: {
        until: [
          { send: menu name: completion_menu }
          { send: menunext }
        ]
      }
    }
    {
      name: completion_previous
      modifier: control
      keycode: char_p
      mode: [emacs, vi_normal, vi_insert] # Note: You can add the same keybinding to all modes by using a list
      event: { send: menuprevious }
    }
    {
      name: completion_previous_1
      modifier: control
      keycode: backspace
      mode: [emacs, vi_normal, vi_insert] # Note: You can add the same keybinding to all modes by using a list
      event: { send: menuprevious }
    }
  ]
}


source ~/dotfiles/commands.nu
