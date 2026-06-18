export PATH="$HOME/.bin:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"

# Homebrew
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

if [[ -d "$HOME/.workbin" ]]; then
  export PATH="$HOME/.workbin:$PATH"
fi

# Go
if [[ -d "$HOME/go/bin" ]]; then
  export PATH="$HOME/go/bin:$PATH"
fi

export EDITOR="nvim"
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export LESS=-R

# Secrets and machine-local env vars
[[ -f "$HOME/dotfiles/.env" ]] && set -a && source "$HOME/dotfiles/.env" && set +a

# Use neovim if it's installed
if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

# Enable completion
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit -C   # skip audit, dump is fresh
else
  compinit       # full audit + rebuild
fi

autoload -U select-word-style
select-word-style bash

# Prefix-aware search history
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

[[ -f ~/.aliases ]] && source ~/.aliases
[[ -f ~/.workaliases ]] && source ~/.workaliases

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Tab accepts the autosuggestion ghost text if one is showing,
# otherwise falls back to normal completion.
_autosuggest_accept_or_complete() {
  if [[ -n $POSTDISPLAY ]]; then
    zle autosuggest-accept
  else
    zle expand-or-complete
  fi
}
zle -N _autosuggest_accept_or_complete
bindkey '^I' _autosuggest_accept_or_complete

# https://mise.jdx.dev/
eval "$(mise activate zsh)"
# https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init --cmd j zsh)"
# https://docs.atuin.sh/
eval "$(atuin init zsh --disable-up-arrow)"
# https://starship.rs/
eval "$(starship init zsh)"

# opencode
export PATH=/Users/icenine/.opencode/bin:$PATH
