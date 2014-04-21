c() {
    cd "$1"
    ls -a
}

die() {
    sudo shutdown -h now
}

alias open=gnome-open
alias tmux="TERM=screen-256color-bce tmux"

# No ttyctl, so we need to save and then restore terminal settings
vim()
{
    # osx users, use stty -g
    local STTYOPTS="$(stty --save)"
    stty stop '' -ixoff
    command vim "$@"
    stty "$STTYOPTS"
}
