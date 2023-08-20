# Nushell Config File

# use ~/dotfiles/nu_scripts/custom-completions/cargo/cargo-completions.nu *
# use ~/dotfiles/nu_scripts/custom-completions/git/git-completions.nu *
# use ~/dotfiles/nu_scripts/custom-completions/npm/npm-completions.nu *

# for more information on themes see
# https://www.nushell.sh/book/coloring_and_theming.html
let default_theme = {
    # color for nushell primitives
    separator: white
    leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
    header: green_bold
    empty: blue
    bool: white
    int: white
    filesize: white
    duration: white
    date: white
    range: white
    float: white
    string: white
    nothing: white
    binary: white
    cellpath: white
    row_index: green_bold
    record: white
    list: white
    block: white
    hints: dark_gray

    # shapes are used to change the cli syntax highlighting
    shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
    shape_binary: purple_bold
    shape_bool: light_cyan
    shape_int: purple_bold
    shape_float: purple_bold
    shape_range: yellow_bold
    shape_internalcall: cyan_bold
    shape_external: cyan
    shape_externalarg: green_bold
    shape_literal: blue
    shape_operator: yellow
    shape_signature: green_bold
    shape_string: green
    shape_string_interpolation: cyan_bold
    shape_datetime: cyan_bold
    shape_list: cyan_bold
    shape_table: blue_bold
    shape_record: cyan_bold
    shape_block: blue_bold
    shape_filepath: cyan
    shape_globpattern: cyan_bold
    shape_variable: purple
    shape_flag: blue_bold
    shape_custom: green
    shape_nothing: light_cyan
}

# The default config record. This is where much of your global configuration is setup.
let-env config = {
  show_banner: false
  color_config: $default_theme
  use_grid_icons: true
  footer_mode: "25" # always, never, number_of_rows, auto
  float_precision: 2
  use_ansi_coloring: true
  edit_mode: emacs # emacs, vi
  cursor_shape: {
    emacs: block # block, underscore, line (line is the default)
    vi_insert: block # block, underscore, line (block is the default)
    vi_normal: underscore # block, underscore, line  (underscore is the default)
  }
  completions: {
    case_sensitive: false # set to true to enable case-sensitive completions
    quick: false  # set this to false to prevent auto-selecting completions when only one remains
    partial: true  # set this to false to prevent partial filling of the prompt
    algorithm: "prefix"  # prefix or fuzzy
    external: {
      enable: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up my be very slow
      max_results: 100 # setting it lower can improve completion performance at the cost of omitting some options
      completer: null # check 'carapace_completer' above as an example
    }
  }
  ls: {
    use_ls_colors: true # use the LS_COLORS environment variable to colorize output
    clickable_links: true # enable or disable clickable links. Your terminal has to support links.
  }
  rm: {
    always_trash: true # always act as if -t was given. Can be overridden with -p
  }
  cd: {
    abbreviations: true # allows `cd s/o/f` to expand to `cd some/other/folder`
  }
  table: {
    mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
    index_mode: always # "always" show indexes, "never" show indexes, "auto" = show indexes when a table has "index" column
    trim: {
      methodology: wrapping # wrapping or truncating
      wrapping_try_keep_words: true # A strategy used by the 'wrapping' methodology
      truncating_suffix: "..." # A suffix used by the 'truncating' methodology
    }
  }
  filesize: {
    metric: true # true => KB, MB, GB (ISO standard), false => KiB, MiB, GiB (Windows standard)
    format: "auto" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, zb, zib, auto
  }
  history: {
    max_size: 10000 # Session has to be reloaded for this to take effect
    sync_on_enter: true # Enable to share history between multiple sessions, else you have to close the session to write history to file
    file_format: "plaintext" # "sqlite" or "plaintext"
  }
  menus: [
      # Configuration for default nushell menus
      # Note the lack of souce parameter
      {
        name: completion_menu
        only_buffer_difference: false
        marker: "| "
        type: {
            layout: columnar
            columns: 4
            col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
            col_padding: 2
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
      }
      {
        name: history_menu
        only_buffer_difference: true
        marker: "? "
        type: {
            layout: list
            page_size: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
      }
      {
        name: help_menu
        only_buffer_difference: true
        marker: "? "
        type: {
            layout: description
            columns: 4
            col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
            col_padding: 2
            selection_rows: 4
            description_rows: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
      }
      # Example of extra menus created using a nushell source
      # Use the source field to create a list of records that populates
      # the menu
      {
        name: commands_menu
        only_buffer_difference: false
        marker: "# "
        type: {
            layout: columnar
            columns: 4
            col_width: 20
            col_padding: 2
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
        source: { |buffer, position|
            $nu.scope.commands
            | where command =~ $buffer
            | each { |it| {value: $it.command description: $it.usage} }
        }
      }
      {
        name: vars_menu
        only_buffer_difference: true
        marker: "# "
        type: {
            layout: list
            page_size: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
        source: { |buffer, position|
            $nu.scope.vars
            | where name =~ $buffer
            | sort-by name
            | each { |it| {value: $it.name description: $it.type} }
        }
      }
      {
        name: commands_with_description
        only_buffer_difference: true
        marker: "# "
        type: {
            layout: description
            columns: 4
            col_width: 20
            col_padding: 2
            selection_rows: 4
            description_rows: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
        source: { |buffer, position|
            $nu.scope.commands
            | where command =~ $buffer
            | each { |it| {value: $it.command description: $it.usage} }
        }
      }
  ]
  keybindings: [
    {
      name: history_hint
      name: commands_menu
      modifier: control
      keycode: tab
      mode: emacs
      event: [ { send: HistoryHintComplete } ]
    }
    {
      name: history_hint_word
      name: commands_menu
      modifier: none
      keycode: tab
      mode: emacs
      event: [ { send: HistoryHintWordComplete } ]
    }
    {
      name: completion_menu
      modifier: control
      keycode: char_l
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
      keycode: char_h
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
    # Keybindings used to trigger the user defined menus
    {
      name: commands_menu
      modifier: control
      keycode: char_t
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: commands_menu }
    }
    {
      name: vars_menu
      modifier: control
      keycode: char_y
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: vars_menu }
    }
  ]
}


###### ALIAS ######

alias g = git
# alias ex = start /B files .
alias ex = explorer .
alias gg = git grep -IPn --color=always --recurse-submodules
alias ggn = git grep -IPn --color=always
alias gr = git grep --no-index -IPn --color=always
alias rcname = python -c "for i,c in enumerate(f'{input():<12}'[:12]): print(f'\t<C{i+1:>02}>{ord(c)}</C{i+1:>02}>')"

alias darkcol = cp ~/dotfiles/delta-config/dark.gitconfig ~/dotfiles/delta-config/current.gitconfig
alias lightcol = cp ~/dotfiles/delta-config/light.gitconfig ~/dotfiles/delta-config/current.gitconfig
alias ansicol = cp ~/dotfiles/delta-config/ansi.gitconfig ~/dotfiles/delta-config/current.gitconfig

alias l = ls -a
alias ll = ls -alf
# On windows the npm.cmd gives strange errors, but the bash script does not.
# alias npm = if (sys).host.name == "Windows" { bash 'C:\Program Files\nodejs\npm' } else { npm }
alias wnpm = bash 'C:\Program Files\nodejs\npm'
alias npr = npm run -- 
alias npe = npm exec -- 
alias replac = perl ~/dotfiles/replac/replac.pl

alias t = task


###### COMMAND ######

def-env c [path] {
  cd $path
  ls -sa
}

def tstop [] {
  task rc.confirmation=off rc.bulk:0 status:pending +ACTIVE ids | xargs -i task {} stop
}
def tsw [task] {
  tstop
  task $task start
}
def-env twrap [] {
  tstop
  cd ~/.task
  git add .
  git commit -m "Wrap up"
  git push
  cd
}

def colors [] {
  [30 40 90 100] | each { |$color_offset| 
    0..9 | each { |$color|
      if $color != 8 { # 8 is not a color code
        1..9 | each { |$style|
          build-string $"\e[($color + $color_offset);($style)m" $'\e[($color + $color_offset)($style)m' "\e[0m"
        } | str collect
      }
    } | flatten
  } | flatten
}

def 256colors [] {
  0..255 | each { |$color|
    build-string $"\e[38;5;($color)m" $'($color)' "\e[0m"
  } | str collect
}


def "git cb" [] {
  let branches = (git branch --color=never | lines | where (($it | str starts-with "*") == false))
  echo $branches
  let input = (input "Type branch number to checkout and press enter to move on: " | str trim -a)
  if (($input | str length) > 0) {
    let index = ($input | into int)
    let branch = ($branches | get $index | str trim -a)
    ^git checkout $branch
  } else {
    echo Aborting...
  }
}
