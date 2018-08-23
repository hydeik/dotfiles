#
# Miscillaneous configurations
#

# junegunn/fzf

export FZF_DEFAULT_OPTS='--height=40% --border'
# Default command for fzf
if (( ${+commands[fd]} )); then
    export FZF_DEFAULT_COMMAND='fd --type f'
    export FZF_CTRL_T_COMMAND="${FZF_CTRL_T_COMMAND}"
    export FZF_CTRL_T_OPT="--multi --preview 'head -$LINES {}'"
    export FZF_ALT_C_COMMAND='fd --type d'
elif (( ${+commands[rg]} )); then
    export FZF_DEFAULT_COMMAND='rg --file --hidden --follow --glob "!.git/*"'
    export FZF_CTRL_T_COMMAND="${FZF_CTRL_T_COMMAND}"
    export FZF_CTRL_T_OPT="--multi --preview 'head -$LINES {}'"
fi

if [[ -n "$TMUX" ]]; then
    FZF_TMUX=1
    FZF_TMUX_HEIGHT='25%'
fi

# Load custom functions
autoload -Uz fzf-cd-ghq-repo fzf-cdr
zle -N fzf-cd-ghq-repo
zle -N fzf-cdr

# Keybind
bindkey '^R'  fzf-history-widget
bindkey '^T'  fzf-file-widget
bindkey '\ec' fzf-cd-widget

bindkey '^g'  fzf-cd-ghq-repo
bindkey '^]'  fzf-cdr

