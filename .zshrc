echo Executing .zshrc

# export STARSHIP_LOG=trace

source ~/.bash_aliases

# Editor + History
export EDITOR="hx"
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt inc_append_history share_history

# Readline-style keybindings
bindkey -e

# Add custom completions *before* compinit
fpath+=(~/prj/dotfiles/zsh/zsh-completions/src)

# Completion system
autoload -Uz compinit && compinit
# Prompt theming system
autoload -Uz promptinit && promptinit

# 1) Partial accept with Ctrl-L
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(forward-word)
bindkey '^L' forward-word

# 2) Accept & execute with Ctrl+O
ZSH_AUTOSUGGEST_EXECUTE_WIDGETS+=(autosuggest-execute)
bindkey '^O' autosuggest-execute

# Source plugins
source ~/prj/dotfiles/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/prj/dotfiles/zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/prj/dotfiles/zsh/fzf-tab/fzf-tab.plugin.zsh

eval "$(starship init zsh)"
