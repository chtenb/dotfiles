echo Executing .bashrc

[ -f "/c/ghcup/env" ] && . "/c/ghcup/env" # ghcup-env

export SHELLOPTS
set -o igncr

# Enable ** globbing
shopt -s globstar

source ~/.bash_aliases

PROMPT_COMMAND='history -a'

export PATH
