# Fast dir crawling
c() {
    cd "$1"
    ls -a
}

# Print stderr in red. Usage: $ color command.
color()(set -o pipefail;"$@" 2>&1>&3|sed $'s,.*,\e[31m&\e[m,'>&2)3>&1

if [ -f ~/dotfiles/hub.bash_completion.sh ]; then
  . ~/dotfiles/hub.bash_completion.sh
fi

alias g="hub"
if [ -x "$(command -v __git_complete)" ]; then
    __git_complete g __git_main
fi
alias ex="explorer ."
alias gg="git grep -IPn --color=always --recurse-submodules"
alias ggn="git grep -IPn --color=always"
alias gr="grep -rIPn --color=always"
alias die="sudo shutdown -h now"
alias open="gnome-open"
alias tmux="TERM=screen-256color-bce tmux"
alias lesser="less --tabs=4 -RFX"

# Ping google server
alias pingg="ping google.nl"

# Prevent gvim from print annoying error message
alias gvim="gvim 2> /dev/null"

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

# Setup arcanist
PATH=$PATH:~/Projects/php/
PATH=$PATH:~/Projects/arcanist/bin/
if [ -d "~/Projects/arcanist/" ]
then
    PATH=$PATH:~/Projects/php/
    PATH=$PATH:~/Projects/arcanist/bin/
    source ~/Projects/arcanist/resources/shell/bash-completion
fi
