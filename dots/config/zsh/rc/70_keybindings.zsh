##=====================================================================
## rc/60_bindkey.zsh -- set keybindings on command line
##=====================================================================

# Emacs like keybindings as default
bindkey -e

# complete on tab, leave expansion to _expand
bindkey '^I' complete-word

# M-h run-help -> backward-kill-word
bindkey "^[h" backward-kill-word  # Bind to M-h
bindkey "^[^H" run-help           # Bind to C-M-h

# zsh-history-substring-search
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# if (( ${+commands[fzf]} )); then
#     # Load custom functions
#     autoload -Uz fzf-cd-ghq-repo fzf-cdr
#     zle -N fzf-cd-ghq-repo
#     zle -N fzf-cdr
#
#     # Keybindings for fzf
#     #
#     # NOTE: Keybindinds pre-defined in key_bindings.zsh in fzf are rebound
#     # below, as 'bindkey -e' overwrite them.
#     bindkey '^I'  fzf-completion
#     bindkey '^R'  fzf-history-widget
#     bindkey '^T'  fzf-file-widget
#     bindkey '\ec' fzf-cd-widget
#
#     bindkey '^G'  fzf-cd-ghq-repo
#     bindkey '^]'  fzf-cdr
# fi


# zeno.zsh
if [[ -n $ZENO_LOADED ]]; then
  # bindkey ' '  zeno-auto-snippet

  # fallback if snippet not matched (default: self-insert)
  # export ZENO_AUTO_SNIPPET_FALLBACK=self-insert

  # if you use zsh's incremental search
  # bindkey -M isearch ' ' self-insert
  # bindkey ' '  zeno-auto-snippet
  bindkey '^m' zeno-auto-snippet-and-accept-line

  bindkey '^i' zeno-completion

  bindkey '^x '  zeno-insert-space
  bindkey '^x^m' accept-line
  bindkey '^x^z' zeno-toggle-auto-snippet

  # fallback if completion not matched
  # (default: fzf-completion if exists; otherwise expand-or-complete)
  # export ZENO_COMPLETION_FALLBACK=expand-or-complete

  # ZLE widget
  bindkey '^r'   zeno-history-selection
  bindkey '^x^s' zeno-insert-snippet
  bindkey '^x^f' zeno-ghq-cd
fi

# ----- End of zshrc -----
# vim: foldmethod=marker
