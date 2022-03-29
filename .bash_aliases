# Setup node via NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Setup Nix
if [ -e /home/chiel/.nix-profile/etc/profile.d/nix.sh ]; then . /home/chiel/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# Enable ** globbing
shopt -s globstar

# Set up starship
export STARSHIP_CONFIG=~/dotfiles/starship.toml
eval "$(starship init bash)"

export PAGER="less --tabs=4 -RF"
alias lesser="less --tabs=4 -RF"

# jj completion
# source <(jj debug completion)

# Fast dir crawling
c() {
    cd "$1"
    ls -a --color --classify
}

# Filemanager
f() {
    fff "$@"
    cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
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
if [ "$(command -v __git_complete)" ]; then
    __git_complete g __git_main
else
    source /usr/share/bash-completion/completions/git
    __git_complete g __git_main
fi

alias ex="explorer ."
alias gg="git grep -IPn --color=always --recurse-submodules"
alias ggn="git grep -IPn --color=always"
alias gr="git grep --no-index -IPn --color=always"
alias rcname="python -c \"for i,c in enumerate(f'{input():<12}'[:12]): print(f'\t<C{i+1:>02}>{ord(c)}</C{i+1:>02}>')\""
#alias die="sudo shutdown -h now"
alias open="gnome-open"
alias tmux="TERM=screen-256color-bce tmux"

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

alias dark="cp -f ~/dotfiles/delta-config/dark.gitconfig ~/dotfiles/delta-config/current.gitconfig"
alias light="cp -f ~/dotfiles/delta-config/light.gitconfig ~/dotfiles/delta-config/current.gitconfig"

