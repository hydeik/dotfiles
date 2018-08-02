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

# pip
if (( ${+commands[pip]} )); then
    function _pip_completion {
        local words cword
        read -Ac words
        read -cn cword
        reply=( $( COMP_WORDS="$words[*]" \
                   COMP_CWORD=$(( cword-1 )) \
                   PIP_AUTO_COMPLETE=1 $words[1] ) )
    }
    compctl -K _pip_completion pip
    if (( ${+commands[pip3]})); then
        compctl -K _pip_completion pip3
    fi
fi

# pyenv
if (( ${+commands[pyenv]} )); then
    compctl -K _pyenv pyenv

    _pyenv() {
        local words completions
        read -cA words

        if [ "${#words}" -eq 2 ]; then
          completions="$(pyenv commands)"
        else
          completions="$(pyenv completions ${words[2,-2]})"
        fi

        reply=(${(ps:\n:)completions})
    }
fi

# pipenv
if (( ${+commands[pipenv]} )); then
    #compdef pipenv
    _pipenv() {
        eval $(env COMMANDLINE="${words[1,$CURRENT]}" _PIPENV_COMPLETE=complete-zsh pipenv)
    }
    if [[ "$(basename ${(%):-%x})" != "_pipenv" ]]; then
        # autoload -U compinit && compinit   # <- compinit already called
        compdef _pipenv pipenv
    fi
fi
