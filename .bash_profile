export SHELLOPTS
set -o igncr

# Fast dir crawling
c() {
    cd "$1"
    ls -a
}

alias ex="explorer ."
alias gg="git grep -IPn --color"
alias gr="grep -rIPn --color"
alias pingg="ping google.nl"
alias die="sudo shutdown -h now"
alias open="gnome-open"
alias tmux="TERM=screen-256color-bce tmux"

# Add local bin directory to path
PATH=$PATH:~/bin
