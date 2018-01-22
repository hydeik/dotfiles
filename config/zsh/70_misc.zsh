# 
# Miscillaneous configurations
#
export INTERACTIVE_FILTER="fzy:fzf:peco:percol:gof:pick"

# junegunn/fzf
export FZF_DEFAULT_OPTS='
--extended
--ansi
--multi
--bind=ctrl-u:page-up
--bind=ctrl-d:page-down
--bind=ctrl-z:toggle-all
'

if [[ -n "$TMUX" ]]; then
    FZF_TMUX=1
    FZF_TMUX_HEIGHT='25%'
fi

# mollifier/anyframe
zstyle ':anyframe:selector:fzf-tmux:' command "fzf-tmux -d ${FZF_TMUX_HEIGHT}"


