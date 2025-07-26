# Nushell Environment Config File

###### PATH ######
let new_paths = if (sys host).name == "Windows" {
  ['D:\git\usr\bin', 
  'C:\Program Files\Microsoft Visual Studio\2022\Professional\Msbuild\Current\Bin',
  'C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin',
  'c:\users\chieltenbrinke\.local\share\helix',
  'C:\Users\chieltenbrinke\Programs\ImageMagick',
  'C:\Program Files\Chez Scheme 10.1.0\bin\a6nt',
  'C:\Program Files\Racket'
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
  'c:\users\chieltenbrinke\dotfiles\bat'
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
alias koka = C:\Users\ChieltenBrinke\prj\koka\.stack-work\install\80fdb312\bin\koka.exe
alias kk = C:\Users\ChieltenBrinke\prj\koka\.stack-work\install\80fdb312\bin\koka.exe -iC:\Users\chieltenbrinke\prj

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

if $nu.os-info.name == "windows" {
  # Make some programs not assume CP 1252, but default to UTF8
  chcp 65001 | save NUL 
}
