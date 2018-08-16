#
# Miscillaneous configurations
#

# junegunn/fzf
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS='--ansi --multi --height=40% --border'

if [[ -n "$TMUX" ]]; then
    FZF_TMUX=1
    FZF_TMUX_HEIGHT='25%'
fi

# mollifier/anyframe
zstyle ':anyframe:selector:fzf:' command "fzf ${FZF_DEFAULT_OPTS}"
zstyle ':anyframe:selector:fzf-tmux:' command "fzf-tmux -d ${FZF_TMUX_HEIGHT}"

