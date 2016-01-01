# Fast dir crawling
c() {
    cd "$1"
    ls -a
}

# Ping google server
alias pingg="ping google.nl"

# Prevent gvim from print annoying error message
alias gvim="gvim 2> /dev/null"

# Some git aliases
alias pull="git pull; git submodule update --recursive"
alias push="git push"
alias commit="git commit -a"

# Misc aliases
alias die="sudo shutdown -h now"
alias open=gnome-open
alias tmux="TERM=screen-256color-bce tmux"
alias fate="python3 ~/Projects/tfate/main.py"
alias gfate="python3 ~/Projects/gfate/main.py"
alias replace="perl ~/Projects/dotfiles/replace.pl"

# No ttyctl, so we need to save and then restore terminal settings
vim()
{
    # osx users, use stty -g
    local STTYOPTS="$(stty --save)"
    stty stop '' -ixoff
    command vim "$@"
    stty "$STTYOPTS"
}

# Set proper $TERM if we are running gnome-terminal
if [ "$COLORTERM" == "gnome-terminal" ]
then
    TERM=xterm-256color
fi

# Add local bin directory to path
PATH=$PATH:~/bin

