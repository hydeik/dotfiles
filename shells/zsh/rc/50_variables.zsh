##=====================================================================
## rc/50_variables.zsh -- set variables to customize commands
##=====================================================================

## --- Colors for ls
# {{{
# for GNU ls
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# for BSD, OSX (builtin)
export LSCOLORS=exfxcxdxbxegedabagacad
# }}}

## --- Customize less
# {{{

# Less status line
export LESS='-R -f -X -i -P ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'
export LESSCHARSET='utf-8'
# Less history file
export LESSHISTFILE="${XDG_CACHE_HOME}/less/history"

# LESS man page colors (makes Man pages more readable).
# Source: http://unix.stackexchange.com/a/147
# More info: http://unix.stackexchange.com/a/108840
#
# The `tput` command is a little bit slow, so I wrote the following wrapper
# function to set LESS_TERMCAP_** when `less` is called first time.
less() {
    export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
    export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan
    export LESS_TERMCAP_me=$(tput sgr0)
    export LESS_TERMCAP_so=$(tput bold; tput setaf 0; tput setab 4) # black on blue
    export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
    export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
    export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
    export LESS_TERMCAP_mr=$(tput rev)
    export LESS_TERMCAP_mh=$(tput dim)
    export LESS_TERMCAP_ZN=$(tput ssubm)
    export LESS_TERMCAP_ZV=$(tput rsubm)
    export LESS_TERMCAP_ZO=$(tput ssupm)
    export LESS_TERMCAP_ZW=$(tput rsupm)
    # Call less command directly next time
    unset -f less
    less "$@"
}

# }}}

## --- History
# {{{

# History file
HISTFILE="${ZDOTDIR}/zsh_history"
# History size in memory
HISTSIZE=100000
# The number of histsize
SAVEHIST=100000
# The size of asking history
LISTMAX=100
# Do not record command line history in root
if [[ "$UID" == 0 ]]; then
    unset HISTFILE
    SAVEHIST=0
fi

# }}}

## --- Timing information
# {{{

# Print execution statistics upon completion whenever a command takes more than
# $REPORTTIME sec.
REPORTTIME=5

# Customize print format
# TIMEFMT="\
#     The name of this job.             :%J
#     CPU seconds spent in user mode.   :%U
#     CPU seconds spent in kernel mode. :%S
#     Elapsed time in seconds.          :%E
#     The  CPU percentage.              :%P"

# }}}

## --- Watching login/logout
# {{{

# Watching other users
watch=(notme)
# Check every 60 seconds.
LOGCHECK=60
# Format message printed on login/logout
WATCHFMT="%(a:${fg[blue]}Hello %n [%m] [%t]:${fg[red]}Bye %n [%m] [%t])"

# }}}

## --- junegunn/fzf
# {{{

if (( ${+commands[fzf]} )); then
    # Default options passed to `fzf`
    export FZF_DEFAULT_OPTS='--height=50% --border'

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
fi

# }}}

# ----- End of file -----
# vim: foldmethod=marker
