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

ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(forward-word)
bindkey '^L' forward-word

ZSH_AUTOSUGGEST_EXECUTE_WIDGETS+=(autosuggest-execute)
bindkey '^O' autosuggest-execute

# TODO: make neo-ansi version
export FZF_DEFAULT_OPTS='--color=16'

# Source plugins
source ~/prj/dotfiles/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/prj/dotfiles/zsh/fzf-tab/fzf-tab.plugin.zsh

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
# zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes

source ~/prj/dotfiles/zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

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
