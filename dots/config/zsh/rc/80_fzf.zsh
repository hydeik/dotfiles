##=====================================================================
## rc/80_fzf.zsh -- Configurations for FZF
##=====================================================================

## --- Environment variables for controling fzf behaviors

# Default options passed to `fzf`
export FZF_DEFAULT_OPTS='--height=50% --border'
# fzf on Tmux popup window
export FZF_TMUX=1
export FZF_TMUX_OPTS='-p'

# Trigger sequence for fuzzy completion [default: '**']
export FZF_COMPLETION_TRIGGER=','

# Use fd instead of the default find command for listing path candidates.
if (( ${+commands[fd]} )); then
    export FZF_DEFAULT_COMMAND='fd --type f'
    export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
    export FZF_CTRL_T_OPT="--multi --preview 'head -$LINES {}'"
    export FZF_ALT_C_COMMAND='fd --type d'

    # Path completion
    _fzf_compgen_path() {
        fd --hidden --follow --exclude ".git" . "$1"
    }

    # Directory completion
    _fzf_compgen_dir() {
        fd --type d --hidden --follow --exclude ".git" . "$1"
    }
fi

## --- Enable FZF's builtin key-bindings and tab completion
# Nix home-manager
if [[ -r $HM_PROFILE_DIR/share/fzf/key-bindings.zsh ]]; then
    source $HM_PROFILE_DIR/share/fzf/key-bindings.zsh
    source $HM_PROFILE_DIR/share/fzf/completion.zsh
fi

# macOS / Homebrew (Apple Silicon)
if [[ -r /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
    source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
    source /opt/homebrew/opt/fzf/shell/completion.zsh
fi

# macOS / Homebrew (Intel)
if [[ -r /usr/local/opt/fzf/shell/key-bindings.zsh ]]; then
    source /usr/local/opt/fzf/shell/key-bindings.zsh
    source /usr/local/opt/fzf/shell/completion.zsh
fi

## --- Custom scripts / key-bindings

function fzf-cdr() {
    local fzf_options="--no-multi --prompt='Directory > ' --query=\"$LBUFFER\""
    if [[ $TMUX && $FZF_TMUX = 1 ]]; then
        local fzf_command="fzf-tmux ${fzf_options} ${FZF_TMUX_OPTS} ${FZF_DEFAULT_OPTS}"
    else
        local fzf_command="fzf ${fzf_options} ${FZF_DEFAULT_OPTS}"
    fi

    local cdr_command="cdr -l | sed 's/^[^ ][^ ]*  *//'"
    local command="${cdr_command} | ${fzf_command}"

    local selected_dir=$(eval $command)
    if [ -n "${selected_dir}" ]; then
        BUFFER="builtin cd ${selected_dir}"
        zle accept-line
    fi

    zle clear-screen
}

function fzf-cd-ghq-repo() {
    local fzf_options="--no-multi --prompt='Repogitory > ' --query=\"$LBUFFER\" --preview='eza -lga --color=always --icons=auto {}'"
    if [[ $TMUX && $FZF_TMUX = 1 ]]; then
        local fzf_command="fzf-tmux ${fzf_options} ${FZF_TMUX_OPTS} ${FZF_DEFAULT_OPTS}"
    else
        local fzf_command="fzf ${fzf_options} ${FZF_DEFAULT_OPTS}"
    fi
    local ghq_command="ghq list --full-path"
    local command="${ghq_command} | ${fzf_command}"
    local selected_dir=$(eval ${command})

    if [ -n "$selected_dir" ]; then
        BUFFER="builtin cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}

zle -N fzf-cd-ghq-repo
bindkey '^G'  fzf-cd-ghq-repo

