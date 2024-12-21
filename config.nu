# Nushell Config File

# use ~/dotfiles/nu_scripts/custom-completions/cargo/cargo-completions.nu *
source ~/dotfiles/custom-completions/git-completions.nu
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
  shell_integration: {
    # osc2 abbreviates the path if in the home_dir, sets the tab/window title, shows the running command in the tab/window title
    osc2: true
    # osc7 is a way to communicate the path to the terminal, this is helpful for spawning new tabs in the same directory
    osc7: true
    # osc8 is also implemented as the deprecated setting ls.show_clickable_links, it shows clickable links in ls output if your terminal supports it. show_clickable_links is deprecated in favor of osc8
    osc8: true
    # osc9_9 is from ConEmu and is starting to get wider support. It's similar to osc7 in that it communicates the path to the terminal
    osc9_9: true
    # osc133 is several escapes invented by Final Term which include the supported ones below.
    # 133;A - Mark prompt start
    # 133;B - Mark prompt end
    # 133;C - Mark pre-execution
    # 133;D;exit - Mark execution finished with exit code
    # This is used to enable terminals to know where the prompt is, the command is, where the command finishes, and where the output of the command is
    # Workaround for issue on windows: https://github.com/nushell/nushell/issues/5585#issuecomment-2138885215
    osc133: false
    # osc633 is closely related to osc133 but only exists in visual studio code (vscode) and supports their shell integration features
    # 633;A - Mark prompt start
    # 633;B - Mark prompt end
    # 633;C - Mark pre-execution
    # 633;D;exit - Mark execution finished with exit code
    # 633;E - NOT IMPLEMENTED - Explicitly set the command line with an optional nonce
    # 633;P;Cwd=<path> - Mark the current working directory and communicate it to the terminal
    # and also helps with the run recent menu in vscode
    osc633: true
    # reset_application_mode is escape \x1b[?1l and was added to help ssh work better
    reset_application_mode: true
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
source ~/.zoxide.nu
