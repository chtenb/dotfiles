c() {
    cd "$1"
    ls -a
}

die() {
    sudo shutdown -h now
}

alias open=gnome-open
alias tmux="TERM=screen-256color-bce tmux"
