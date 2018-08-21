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

# zsh-history-substring-search
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# Anyframe
# zstyle ":anyframe:selector:" use fzf
# autoload -Uz anyframe-init
# anyframe-init

bindkey '^]'   anyframe-widget-cdr

bindkey '^r'   anyframe-widget-put-history
bindkey '^x^r' anyframe-widget-execute-history

bindkey '^x^k' anyframe-widget-kill
bindkey '^x^f' anyframe-widget-insert-filename

bindkey '^g'   anyframe-widget-cd-ghq-repository
bindkey '^x^a' anyframe-widget-git-add
bindkey '^x^b' anyframe-widget-checkout-git-branch
bindkey '^x^i' anyframe-widget-insert-git-branch

# emoji-cli
# bindkey '^x^e' emoji::cli

# Ranger
if (( ${+commands[ranger]} )); then
    autoload -Uz ranger-cd
    bindkey -s '^o' 'ranger-cd^M'
fi

