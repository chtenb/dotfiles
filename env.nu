# Nushell Environment Config File

def create_left_prompt [] {
    let dir = match (do --ignore-shell-errors { $env.PWD | path relative-to $nu.home-path }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }

    let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
    let path_segment = $"($path_color)($dir)"

    $path_segment | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)"
}

def create_right_prompt [] {
    # create a right prompt in magenta with green separators and am/pm underlined
    let time_segment = ([
        (ansi reset)
        (ansi magenta)
        (date now | format date '%x %X') # try to respect user's locale
    ] | str join | str replace --regex --all "([/:])" $"(ansi green)${1}(ansi magenta)" |
        str replace --regex --all "([AP]M)" $"(ansi magenta_underline)${1}")

    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
        (ansi rb)
        ($env.LAST_EXIT_CODE)
    ] | str join)
    } else { "" }

    ([$last_exit_code, (char space), $time_segment] | str join)
}


# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = {|| create_left_prompt }
# FIXME: This default is not implemented in rust code as of 2023-09-08.
$env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| "> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

# If you want previously entered commands to have a different prompt from the usual one,
# you can uncomment one or more of the following lines.
# This can be useful if you have a 2-line prompt and it's taking up a lot of space
# because every command entered takes up 2 lines instead of 1. You can then uncomment
# the line below so that previously entered commands show with a single `🚀`.
# $env.TRANSIENT_PROMPT_COMMAND = {|| "🚀 " }
# $env.TRANSIENT_PROMPT_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = {|| "" }
# $env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_COMMAND_RIGHT = {|| "" }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
]

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | prepend '/some/path')

###### PATH ######
let new_paths = if (sys host).name == "Windows" {
  ['C:\Program Files\Git\usr\bin', 
  'C:\Program Files\Microsoft Visual Studio\2022\Professional\Msbuild\Current\Bin',
  'c:\users\chiel.tenbrinke\.local\share\helix',
  'C:\Users\chiel.tenbrinke\Programs\ImageMagick'
  ]
} else {
  [ '/home/chiel/.cabal/bin'
  , '/home/chiel/.ghcup/bin'
  , '/home/chiel/.cargo/bin'
  , '/home/chiel/.local/bin'
  , '/home/chiel/bin'
  ]
}

let existing_path = if (sys host).name == "Windows" {
  $env.Path
} else {
  $env.PATH
}

$env.Path = ($existing_path | prepend $new_paths)
$env.PATH = ($existing_path | prepend $new_paths)
$env.BAT_CONFIG_DIR = if (sys host).name == "Windows" {
  'c:\users\chiel.tenbrinke\dotfiles\bat'
} else {
  '/home/chiel/dotfiles/bat'
}

# const WINDOWS_CONFIG = "my_windows_config.nu"
# const UNIX_CONFIG = "my_unix_config.nu"

# const ACTUAL_CONFIG = if $nu.os-info.name == "windows" {
#     $WINDOWS_CONFIG
# } else {
#     $UNIX_CONFIG
# }

# source $ACTUAL_CONFIG

$env.LC_ALL = "C.utf8"


$env.LS_COLORS = "rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"

$env.EDITOR = "hx"
$env.SHELL = "nu"

$env.koka_editor = "hx"
alias koka = C:\Users\ChieltenBrinke\prj\koka\.stack-work\install\dada82f2\bin\koka.exe
alias kk = C:\Users\ChieltenBrinke\prj\koka\.stack-work\install\dada82f2\bin\koka.exe -iC:\Users\chiel.tenbrinke\prj

# Our Helix config directory is dotfiles/helix, so the default runtime directory is dotfiles/helix/runtime.
# But we keep that directory non-existent and set the HELIX_RUNTIME variable to prj/helix/runtime, such that the grammars and queries are automatically up-to-date.
# Also, we must never run hx --grammar fetch manually, because that will create %APPDATA%/helix/runtime, which takes precedence over HELIX_RUNTIME
# This will immediately break highlighting, because --grammar fetch does not fetch queries, and %APPDATA%/helix/runtime will now take precedence over prj/helix/runtime where our queries are.
$env.HELIX_RUNTIME = if (sys host).name == "Windows" {
  'c:\users\chieltenbrinke\prj\helix\runtime'
} else {
  '/home/chiel/prj/helix/runtime'
}

source ~/dotfiles/broot/launcher/nushell/br

def --env y [...args] {
  let tmp = (mktemp -t "yazi-cwd.XXXXXX")
  yazi ...$args --cwd-file $tmp
  let cwd = (open $tmp)
  if $cwd != "" and $cwd != $env.PWD {
    cd $cwd
  }
  rm -fp $tmp
}

let plantuml_files = (glob "~/.local/bin/plantuml.jar")
if ($plantuml_files | length) > 0 {
  $env.PLANTUML = ($plantuml_files | get 0)
}

# Initialize nvm on linux so we can use npm
if $nu.os-info.name != "windows" {
  let NVM_SCRIPT = glob '~/.nvm/nvm.sh'
  if ($NVM_SCRIPT | length) == 1 {
    $env.PATH = (bash -c $'source ($NVM_SCRIPT) && echo $PATH')
  }
}


# Disable some dotnet repl stuff
$env.DOTNET_INTERACTIVE_CLI_TELEMETRY_OPTOUT = 1
$env.DOTNET_INTERACTIVE_SKIP_FIRST_TIME_EXPERIENCE = 1

zoxide init nushell | save -f ~/.zoxide.nu
