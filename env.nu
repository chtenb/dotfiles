# Nushell Environment Config File

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) }
    to_string: { |v| $v | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) }
    to_string: { |v| $v | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
$env.NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
$env.NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | prepend '/some/path')

###### PATH ######
let new_paths = if (sys).host.name == "Windows" {
  ['C:\Program Files\Git\usr\bin', 'C:\Program Files\Microsoft Visual Studio\2022\Professional\Msbuild\Current\Bin']
} else {
  ['/home/chiel/.cabal/bin', '/home/chiel/.ghcup/bin']
}

let existing_path = if (sys).host.name == "Windows" {
  $env.Path
} else {
  $env.PATH
}

$env.Path = ($existing_path | prepend $new_paths)
$env.PATH = ($existing_path | prepend $new_paths)
$env.BAT_CONFIG_DIR = if (sys).host.name == "Windows" {
  'c:\users\chiel.tenbrinke\dotfiles\bat-config'
} else {
  '/home/chiel/dotfiles/bat-config'
}

$env.LC_ALL = "en_US.UTF-8"


$env.LS_COLORS = "rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"


###### STARSHIP ######
# let-env STARSHIP_SHELL = "nu"
# let-env STARSHIP_SESSION_KEY = (random chars -l 16)
# let-env PROMPT_MULTILINE_INDICATOR = (^starship prompt --continuation)
# let-env PROMPT_INDICATOR = ""

# let-env PROMPT_COMMAND = {
#     # jobs are not supported
#     let width = (term size | get columns | into string)
#     ^starship prompt $"--cmd-duration=($env.CMD_DURATION_MS)" $"--status=($env.LAST_EXIT_CODE)" $"--terminal-width=($width)"
# }

# # Not well-suited for `starship prompt --right`.
# # Built-in right prompt is equivalent to $fill$right_format in the first prompt line.
# # Thus does not play well with default `add_newline = True`.
# let-env PROMPT_COMMAND_RIGHT = {''}

# let-env STARSHIP_CONFIG = if (sys).host.name == "Windows" {
#   'C:\users\chiel.tenbrinke\dotfiles\starship.toml'
# } else {
#   '~/dotfiles/starship.toml'
# }       


###### OH-MY-POSH ######
# let-env PROMPT_COMMAND = { oh-my-posh print primary }
# let-env PROMPT_COMMAND_RIGHT = { oh-my-posh print right }
# let-env PROMPT_COMMAND = { oh-my-posh print primary --config ~/dotfiles/spaceship.omp.json }
# let-env PROMPT_COMMAND_RIGHT = { oh-my-posh print right --config ~/dotfiles/spaceship.omp.json }
