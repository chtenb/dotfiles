echo Executing .zshrc

# zmodload zsh/zprof
# export STARSHIP_LOG=trace starship prompt

# Determine if running on Windows (Git Bash, WSL, Cygwin)
is_windows=false
case "$(uname -s)" in
  MINGW*|MSYS*|CYGWIN*|Windows_NT) is_windows=true ;;
esac

source ~/.bash_aliases

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt inc_append_history share_history

# Add custom completions *before* compinit
fpath+=(~/prj/dotfiles/zsh/zsh-completions/src)

autoload -Uz compinit && compinit -C
autoload -Uz promptinit && promptinit # Prompt theming system

eval "$(zoxide init zsh)"
bindkey -e

# Swallow focus-in/out reports (\e[I / \e[O) so they can't do anything
_noop() {}
zle -N _noop
bindkey '\e[I' _noop
bindkey '\e[O' _noop

# Turn off focus reporting if some program (e.g. nvim) left it on
autoload -Uz add-zsh-hook
_disable_focus_reporting() { printf '\e[?1004l' }
add-zsh-hook precmd _disable_focus_reporting

# Emacs-style line editing
bindkey '^A' beginning-of-line      # Ctrl-A → move to start of line
bindkey '^E' end-of-line            # Ctrl-E → move to end of line
bindkey '^K' kill-line              # Ctrl-K → kill to end of line
bindkey '^Y' yank                   # Ctrl-Y → yank (paste) last kill
bindkey '^D' delete-char            # Ctrl-D → delete char under cursor

# Delete under cursor
bindkey '\e[3~' delete-char

# Ctrl-Delete → kill next word
bindkey '\e[3;5~' kill-word

# Ctrl-Left/Right → move by word
bindkey '\e[1;5D' backward-word
bindkey '\e[1;5C' forward-word
bindkey '\e[5D'   backward-word
bindkey '\e[5C'   forward-word

# Home/End → go to start/end of line
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey '\e[H'  beginning-of-line
bindkey '\e[F'  end-of-line

ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(forward-word)
bindkey '^L' forward-word

ZSH_AUTOSUGGEST_EXECUTE_WIDGETS+=(autosuggest-execute)
bindkey '^O' autosuggest-execute

bindkey '^[u' undo

# TODO: make neo-ansi version
export FZF_DEFAULT_OPTS='--color=16'

bindkey '^[p' history-beginning-search-backward
bindkey '^[n' history-beginning-search-forward

# Source plugins
source ~/prj/dotfiles/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/prj/dotfiles/zsh/fzf-tab/fzf-tab.plugin.zsh

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# The windows start command just needs file completion, it's not the job control related linux thing
compdef _files start

# The "fast" highlighting plugin is extremely slow sometimes, especially with git commands
# source ~/prj/dotfiles/zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/prj/dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

echo Initializing starship

export STARSHIP_CONFIG=~/prj/dotfiles/starship.toml
if [ "$is_windows" = true ]; then
  # On windows, LOGNAME contains the domain prefix, so it doesn't match with whatever
  # starship thinks is the login user. So override it, such that it doesn't show when
  # it's the same as the login user.
  export LOGNAME='ChieltenBrinke'
fi
eval "$(starship init zsh)"

# zprof
