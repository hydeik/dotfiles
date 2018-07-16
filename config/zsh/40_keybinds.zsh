#
# Keybinding
#

# Emacs like keybindings as default
bindkey -e
bindkey '^I' complete-word   # complete on tab, leave expansion to _expand

# M-h run-help -> backward-kill-word
autoload -Uz select-word-style
select-word-style default
# この文字を単語の区切りと見なす(適当に調整する)
zstyle ':zle:*' word-chars " _-/;@:{},|"
zstyle ':zle:*' word-style unspecified
bindkey "^[h" backward-kill-word  # Bind to M-h
bindkey "^[^H" run-help           # Bind to C-M-h

# if zplug check "zsh-users/zsh-history-substring-search"; then
#     # history-substring-search
#     bindkey -M emacs '^P' history-substring-search-up
#     bindkey -M emacs '^N' history-substring-search-down

#     #bindkey '^P' history-substring-search-up
#     #bindkey '^N' history-substring-search-down
# else;
#     autoload -Uz history-search-end
#     zle -N history-beginning-search-backward-end history-search-end
#     zle -N history-beginning-search-forward-end history-search-end

#     bindkey "^[p" history-beginning-search-backward-end
#     bindkey "^[n" history-beginning-search-forward-end
# fi

# # Anyframe
# if zplug check "mollifier/anyframe"; then
#     autoload -Uz anyframe-init
#     zstyle ":anyframe:selector:" use fzf
#     anyframe-init

#     bindkey '^x^b' anyframe-widget-checkout-git-branch

#     bindkey '^r'  anyframe-widget-execute-history
#     bindkey '^x^r' anyframe-widget-execute-history

#     bindkey '^xp'  anyframe-widget-put-history
#     bindkey '^x^p' anyframe-widget-put-history

#     bindkey '^g'   anyframe-widget-cd-ghq-repository
#     bindkey '^x^g' anyframe-widget-cd-ghq-repository

#     bindkey '^xk'  anyframe-widget-kill
#     bindkey '^x^k' anyframe-widget-kill

#     bindkey '^xi'  anyframe-widget-insert-git-branch
#     bindkey '^x^i' anyframe-widget-insert-git-branch

#     bindkey '^xf'  anyframe-widget-insert-filename
#     bindkey '^x^f' anyframe-widget-insert-filename
# fi

if (( ${+commands[ranger]} )); then
    autoload -Uz ranger-cd
    bindkey -s '^o' 'ranger-cd^M'
fi

