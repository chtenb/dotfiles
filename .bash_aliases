# Fast dir crawling
c() {
    cd "$1"
    ls -a
}

replace() {
    perl ~/dotfiles/bin/replace.pl "$@"
}

wpy() {
    winpty -Xallow-non-tty python.exe "$@"
}
# Make git grep search submodules as well
gsg() {
    git --no-pager grep "$@"
    git --no-pager submodule foreach --recursive "git --no-pager grep $@ ; true"
}

# tail the latest created file in the directory
taillatest() {
    tail "`ls -t | head -1`" "$@"
}

# Print stderr in red. Usage: $ color command.
color()(set -o pipefail;"$@" 2>&1>&3|sed $'s,.*,\e[31m&\e[m,'>&2)3>&1

wrapup() {
    cd ~/.task
    git commit -u -m "Wrap up"
    git push
    cd
}

alias g="git"
if [ "$(command -v __git_complete)" ]; then
    __git_complete g __git_main
fi

alias l="ls -a --color --classify"
alias ex="explorer ."
alias gg="git grep -IPn --color=always --recurse-submodules"
alias ggn="git grep -IPn --color=always"
alias gr="git grep --no-index -IPn --color=always"
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


# Setup ssh agent according to github docs so we don't need to type ssh keyphrase
# https://docs.github.com/en/github/authenticating-to-github/working-with-ssh-key-passphrases
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env
