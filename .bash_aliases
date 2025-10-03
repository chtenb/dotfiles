export PAGER="less --tabs=4 -RF"
alias lesser="less --tabs=4 -RF"

# Fast dir crawling
c() {
    cd "$1"
    ls -a --color --classify
}

# tail the latest created file in the directory
taillatest() {
    tail "`ls -t | head -1`" "$@"
}

# Print stderr in red. Usage: $ color command.
color() {
  # Detect shell and skip pipefail if unsupported
  if (set -o pipefail 2>/dev/null); then
    set -o pipefail
  fi

  # Run the command, capture stderr only, and color it
  "$@" 2> >(while IFS= read -r line; do printf '\033[31m%s\033[0m\n' "$line"; done)
}

# color()(set -o pipefail;"$@" 2>&1>&3|sed $'s,.*,\e[31m&\e[m,'>&2)3>&1

printcolors(){
    echo "foreground"
    for code in {30..37}; do
    echo -en "\e[${code}m"'\\e['"$code"'m'"\e[0m";
    echo -en "  \e[$code;1m"'\\e['"$code"';1m'"\e[0m";
    echo -en "  \e[$code;2m"'\\e['"$code"';2m'"\e[0m";
    echo -en "  \e[$code;3m"'\\e['"$code"';3m'"\e[0m";
    echo -en "  \e[$code;4m"'\\e['"$code"';4m'"\e[0m";
    echo -en "  \e[$code;5m"'\\e['"$code"';5m'"\e[0m";
    echo -e "  \e[$((code+60))m"'\\e['"$((code+60))"'m'"\e[0m";
    done;
    echo "background"
    for code in {40..47}; do
    echo -en "\e[${code}m"'\\e['"$code"'m'"\e[0m";
    echo -en "  \e[$code;1m"'\\e['"$code"';1m'"\e[0m";
    echo -en "  \e[$code;2m"'\\e['"$code"';2m'"\e[0m";
    echo -en "  \e[$code;3m"'\\e['"$code"';3m'"\e[0m";
    echo -en "  \e[$code;4m"'\\e['"$code"';4m'"\e[0m";
    echo -en "  \e[$code;5m"'\\e['"$code"';5m'"\e[0m";
    echo -e "  \e[$((code+60))m"'\\e['"$((code+60))"'m'"\e[0m";
    done;
}

# neo-ansi: show 256-color samples (like the Nushell version)
# Usage: neo-ansi [-i|--inverse]
neo-ansi() {
  inverse=0
  while [ $# -gt 0 ]; do
    case "$1" in
      -i|--inverse) inverse=1 ;;
      *) printf '%s\n' "Usage: neo-ansi [-i|--inverse]" >&2; return 2 ;;
    esac
    shift
  done

  pad2() { # print $1 as 2 digits with leading zero
    printf '%02d' "$1"
  }

  # header
  printf '%s\n' "BG   CLASS  COLORS"

  eol='\033[K\033[39;49m' # clear to EOL; reset fg/bg

  # initial mode (inverse or reset)
  if [ "$inverse" -eq 1 ]; then
    printf '\033[7m'
  else
    printf '\033[m'
  fi

  bg=0
  while [ "$bg" -le 12 ]; do
    if [ "$bg" -eq 0 ]; then
      bg_code='49'
      bg_name='dflt'
    else
      bg_code="48;5;$((bg + 231))"
      bg_name="bg$(pad2 "$bg")"
    fi

    # normal 0..7
    printf '\033[%sm%s normal ' "$bg_code" "$bg_name"
    color=0
    while [ "$color" -le 7 ]; do
      printf '\033[38;5;%smbase%02d ' "$color" "$color"
      color=$((color + 1))
    done
    printf '%b\n' "$eol"

    # bright 8..15
    printf '\033[%sm%s bright ' "$bg_code" "$bg_name"
    color=8
    while [ "$color" -le 15 ]; do
      printf '\033[38;5;%smbase%02d ' "$color" "$color"
      color=$((color + 1))
    done
    printf '%b\n' "$eol"

    # bold 8..15
    printf '\033[%s;1m%s bold   ' "$bg_code" "$bg_name"
    color=8
    while [ "$color" -le 15 ]; do
      printf '\033[38;5;%smbase%02d ' "$color" "$color"
      color=$((color + 1))
    done
    printf '\033[22m%b\n' "$eol"
    printf '\033[49m' # clear background so the next line starts clean

    # accent line for default bg and first gray bg
    if [ "$bg" -eq 0 ] || [ "$bg" -eq 1 ]; then
      printf '%s accent ' "$bg_name"
      color=12
      while [ "$color" -ge 1 ]; do
        idx=$((256 - color)) # 244..255
        printf '\033[38;5;%smac%02d ' "$idx" "$color"
        color=$((color - 1))
      done
      printf '%b\n' "$eol"
    fi

    bg=$((bg + 1))
  done

  # full reset
  printf '\033[0m'
}

tstop() {
    task rc.confirmation=off rc.bulk:0 status:pending +ACTIVE ids | xargs -i task {} stop;
}
tsw() {
    tstop; task $1 start;
}
twrap() {
    tstop;
    cd ~/.task;
    git add .;
    git commit -m "Wrap up";
    git push;
    cd;
}
tmeet() {
    tsw 30cba286-ca1c-4ff7-b575-246641698a2f;
}
tmail() {
    tsw add54de8-e569-4ad1-aa82-2ab278bfde35;
}

function y() {
 local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
 yazi "$@" --cwd-file="$tmp"
 IFS= read -r -d '' cwd < "$tmp"
 [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
 rm -f -- "$tmp"
}

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias npr='npm run -- '
alias npe='npm exec -- '

venv() {
    source "$1.venv/bin/activate"
}

replac() {
    perl ~/prj/dotfiles/replac/replac.pl "$@"
}
alias selectlines="python ~/prj/dotfiles/scripts/selectlines.py"
alias sl="selectlines"
alias t="task"

alias g="git"
if [ -n "$BASH_VERSION" ]; then
    # Bash
    if command -v __git_complete >/dev/null 2>&1; then
        __git_complete g __git_main
    elif [ -f /usr/share/bash-completion/completions/git ]; then
        source /usr/share/bash-completion/completions/git
        __git_complete g __git_main
    fi
fi
alias gnp="git --no-pager"

alias ex="explorer ."
alias gg="git grep -IPn --color=always --recurse-submodules"
alias ggn="git grep -IPn --color=always"
alias gr="git grep --no-index -IPn --color=always"
alias grec="grep --color"
alias rcname="python -c \"for i,c in enumerate(f'{input():<12}'[:12]): print(f'\t<C{i+1:>02}>{ord(c)}</C{i+1:>02}>')\""
#alias die="sudo shutdown -h now"
alias tmux="TERM=screen-256color-bce tmux"

# Ping google server
alias pingg="ping google.nl"

alias vi="vim -u ~/.vimrc.bare"
alias vix="vim -u ~/.vimrc.helix"
# No ttyctl, so we need to save and then restore terminal settings
vim()
{
    # osx users, use stty -g
    local STTYOPTS="$(stty --save)"
    stty stop '' -ixoff
    command vim "$@"
    stty "$STTYOPTS"
}

vpncli='"/c/Program Files (x86)/Cisco/Cisco Secure Client/vpncli.exe"'
alias vpn-cli="$vpncli"                                   # open CLI
alias ibm-vpn="$vpncli connect \"EUROPE-MEA (windows)\""  # connect to IBM
alias no-vpn="$vpncli disconnect"                         # disconnect
alias delft-vpn='"/c/Program Files/Google/Chrome/Application/chrome.exe" "https://bmfw-052p-e4d-e101.e4d-nl.ibm.com:6081/php/uid.php?vsys=1&rule=0"'
vpn() {
  ibm-vpn
  delft-vpn
  ping -t w3.ibm.com
}


alias admin='powershell -Command "Start-Process nu -Verb RunAs"'

repostat() {
  for dir in ~/prj/Vision*; do
    [ -d "$dir" ] || continue
    (
      cd "$dir" || exit
      basename "$(pwd)"
      git status
    )
  done
}
