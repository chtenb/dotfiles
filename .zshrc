echo Executing .zshrc
# export STARSHIP_LOG=trace

source ~/.bash_aliases

# Editor + History
export EDITOR="hx"
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt inc_append_history share_history

# Completion system
autoload -Uz compinit && compinit
autoload -Uz promptinit && promptinit

# Readline-style keybindings
bindkey -e

# Completion colors and behavior
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Source plugins
source ~/prj/dotfiles/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/prj/dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/prj/dotfiles/zsh/fzf-tab/fzf-tab.plugin.zsh
fpath+=(~/prj/dotfiles/zsh/zsh-completions/src)

eval "$(starship init zsh)"
