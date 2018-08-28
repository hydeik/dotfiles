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

if (( ${+commands[fzf]} )); then
    # Load custom functions
    autoload -Uz fzf-cd-ghq-repo fzf-cdr
    zle -N fzf-cd-ghq-repo
    zle -N fzf-cdr

    # Keybindings for fzf
    #
    # NOTE: Keybindinds pre-defined in key_bindings.zsh in fzf are rebound
    # below, as 'bindkey -e' overwrite them.
    bindkey '^I'  fzf-completion
    bindkey '^R'  fzf-history-widget
    bindkey '^T'  fzf-file-widget
    bindkey '\ec' fzf-cd-widget

    bindkey '^G'  fzf-cd-ghq-repo
    bindkey '^]'  fzf-cdr
fi

# ----- End of zshrc -----
# vim: foldmethod=marker
