export SHELLOPTS
set -o igncr

. ~/.bash_aliases

PROMPT_COMMAND='history -a'

PATH=$PATH:$HOME/.local/bin
PATH=$PATH:$HOME/dotfiles/bin

export PATH
