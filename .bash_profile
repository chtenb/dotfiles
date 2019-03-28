export SHELLOPTS
set -o igncr

. ~/.bash_aliases
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/dotfiles/bin

export PATH
