c() {
    cd "$1"
    ls -a
}

# Some git aliases
alias pull="git pull; git submodule update --recursive"
alias commit="git commit -a"

# Misc aliases
alias die="shutdown -h now"
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
