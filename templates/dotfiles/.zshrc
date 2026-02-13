# Zsh Configuration
# ============================================================================

# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git docker aws brew pip python
  zsh-autosuggestions zsh-syntax-highlighting
  colored-man-pages
)

source $ZSH/oh-my-zsh.sh

# Load bash profile
[ -f ~/.bash_profile ] && source ~/.bash_profile

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null)" || true

# Completions
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Powerlevel10k theme
[ -f "$(brew --prefix 2>/dev/null)/opt/powerlevel10k/powerlevel10k.zsh-theme" ] && \
  source "$(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme"
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
