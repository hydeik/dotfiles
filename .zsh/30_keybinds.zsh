#
# Keybinding
#

# Emacs like keybindings as default
bindkey -e
bindkey '^I' complete-word   # complete on tab, leave expansion to _expand

# history-substring-search
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

#bindkey '^P' history-substring-search-up
#bindkey '^N' history-substring-search-down

# Anyframe
if zplug check "molifier/anyframe"; then
    autoload -Uz anyframe-init
    zstyle ":anyframe:selector:" use fzf
    anyframe-init
    
    bindkey '^x^b' anyframe-widget-checkout-git-branch
    
    bindkey '^xr'  anyframe-widget-execute-history
    bindkey '^x^r' anyframe-widget-execute-history
    
    bindkey '^xp'  anyframe-widget-put-history
    bindkey '^x^p' anyframe-widget-put-history
    
    # bindkey '^xg'  anyframe-widget-cd-ghq-repository
    # bindkey '^x^g' anyframe-widget-cd-ghq-repository
    
    bindkey '^xk'  anyframe-widget-kill
    bindkey '^x^k' anyframe-widget-kill
    
    bindkey '^xi'  anyframe-widget-insert-git-branch
    bindkey '^x^i' anyframe-widget-insert-git-branch
    
    bindkey '^xf'  anyframe-widget-insert-filename
    bindkey '^x^f' anyframe-widget-insert-filename
fi
