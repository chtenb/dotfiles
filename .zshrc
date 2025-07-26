echo Executing .zshrc

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
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[5C' forward-word
bindkey '^[[5D' backward-word

# Completion colors and behavior
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Source plugins
source ~/dotfiles/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dotfiles/zsh/fzf-tab/fzf-tab.plugin.zsh
fpath+=(~/dotfiles/zsh/zsh-completions/src)

eval "$(starship init zsh)"
