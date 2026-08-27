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

# # zsh-history-substring-search
# bindkey -M emacs '^P' history-substring-search-up
# bindkey -M emacs '^N' history-substring-search-down

# edit command-line using EDITOR
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# ----- End of zshrc -----
# vim: foldmethod=marker
