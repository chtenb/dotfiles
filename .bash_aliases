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
    perl ~/dotfiles/replac/replac.pl "$@"
}
alias selectlines="python ~/dotfiles/scripts/selectlines.py"
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

# No ttyctl, so we need to save and then restore terminal settings
vim()
{
    # osx users, use stty -g
    local STTYOPTS="$(stty --save)"
    stty stop '' -ixoff
    command vim "$@"
    stty "$STTYOPTS"
}

alias koka="C:\\Users\\ChieltenBrinke\\prj\\koka\\.stack-work\\install\\80fdb312\\bin\\koka.exe"
alias kk="C:\\Users\\ChieltenBrinke\\prj\\koka\\.stack-work\\install\\80fdb312\\bin\\koka.exe -iC:\\Users\\chieltenbrinke\\prj"

