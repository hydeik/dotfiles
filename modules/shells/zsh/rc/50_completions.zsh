##=====================================================================
## rc/50_completions.zsh -- Set up shell completions
##=====================================================================

# NOTE: Now those tools are installed via nix

# # Generate the zsh completion files from command line
# ZSHCOMPLETIONS="${ZDOTDIR}/completions"
# if [[ ! -r "${ZSHCOMPLETIONS}/_deno" || "$( whence -p deno  )" -nt "${ZSHCOMPLETIONS}/_deno" ]]; then
#     deno completions zsh > "${ZSHCOMPLETIONS}/_deno"
# fi
# if [[ ! -r "${ZSHCOMPLETIONS}/_gh" || "$( whence -p gh  )" -nt "${ZSHCOMPLETIONS}/_gh" ]]; then
#     command gh completion -s zsh > "${ZSHCOMPLETIONS}/_gh"
# fi
# if [[ ! -r "${ZSHCOMPLETIONS}/_poetry" || "$( whence -p poetry  )" -nt "${ZSHCOMPLETIONS}/_poetry" ]]; then
#     poetry completions zsh > "${ZSHCOMPLETIONS}/_poetry"
# fi
# if [[ ! -r "${ZSHCOMPLETIONS}/_mise" || "$( whence -p mise  )" -nt "${ZSHCOMPLETIONS}/_mise" ]]; then
#     mise completion zsh > "${ZSHCOMPLETIONS}/_mise"
# fi
# if [[ ! -r "${ZSHCOMPLETIONS}/_rustup" || "$( whence -p rustup  )" -nt "${ZSHCOMPLETIONS}/_rustup" ]]; then
#     rustup completions zsh > "${ZSHCOMPLETIONS}/_rustup"
#     rustup completions zsh cargo > "${ZSHCOMPLETIONS}/_cargo"
# fi
# unset ZSHCOMPLETIONS

# Speed up zsh compinit by only checking cache once a day.
# This piece of code is taken from
# https://gist.github.com/ctechols/ca1035271ad13484128
if [[ -n ${ZDOTDIR:-${HOME}}/.zcompdump(#qN.mh+24) ]]; then
    compinit;
else
    compinit -C;
fi;

# Read Bash completion specification
bashcompinit

#
# caching the result of `register-python-argcomplete pipx`
#
# Run something, muting output or redirecting it to the debug stream
# depending on the value of _ARC_DEBUG.
# If ARGCOMPLETE_USE_TEMPFILES is set, use tempfiles for IPC.
__python_argcomplete_run() {
    if [[ -z "${ARGCOMPLETE_USE_TEMPFILES-}" ]]; then
        __python_argcomplete_run_inner "$@"
        return
    fi
    local tmpfile="$(mktemp)"
    _ARGCOMPLETE_STDOUT_FILENAME="$tmpfile" __python_argcomplete_run_inner "$@"
    local code=$?
    cat "$tmpfile"
    rm "$tmpfile"
    return $code
}

__python_argcomplete_run_inner() {
    if [[ -z "${_ARC_DEBUG-}" ]]; then
        "$@" 8>&1 9>&2 1>/dev/null 2>&1
    else
        "$@" 8>&1 9>&2 1>&9 2>&1
    fi
}

_python_argcomplete() {
    local IFS=$'\013'
    local SUPPRESS_SPACE=0
    if compopt +o nospace 2> /dev/null; then
        SUPPRESS_SPACE=1
    fi
    COMPREPLY=( $(IFS="$IFS" \
                  COMP_LINE="$COMP_LINE" \
                  COMP_POINT="$COMP_POINT" \
                  COMP_TYPE="$COMP_TYPE" \
                  _ARGCOMPLETE_COMP_WORDBREAKS="$COMP_WORDBREAKS" \
                  _ARGCOMPLETE=1 \
                  _ARGCOMPLETE_SUPPRESS_SPACE=$SUPPRESS_SPACE \
                  __python_argcomplete_run "$1") )
    if [[ $? != 0 ]]; then
        unset COMPREPLY
    elif [[ $SUPPRESS_SPACE == 1 ]] && [[ "${COMPREPLY-}" =~ [=/:]$ ]]; then
        compopt -o nospace
    fi
}

# pipx
if (( ${+commands[pipx]} )); then
    complete -o nospace -o default -o bashdefault -F _python_argcomplete pipx
fi

##
## Caching the result of (_VERDI_COMPLETE=zsh_source verdi)
##
#compdef verdi

_verdi_completion() {
    local -a completions
    local -a completions_with_descriptions
    local -a response
    (( ! $+commands[verdi] )) && return 1

    response=("${(@f)$(env COMP_WORDS="${words[*]}" COMP_CWORD=$((CURRENT-1)) _VERDI_COMPLETE=zsh_complete verdi)}")

    for type key descr in ${response}; do
        if [[ "$type" == "plain" ]]; then
            if [[ "$descr" == "_" ]]; then
                completions+=("$key")
            else
                completions_with_descriptions+=("$key":"$descr")
            fi
        elif [[ "$type" == "dir" ]]; then
            _path_files -/
        elif [[ "$type" == "file" ]]; then
            _path_files -f
        fi
    done

    if [ -n "$completions_with_descriptions" ]; then
        _describe -V unsorted completions_with_descriptions -U
    fi

    if [ -n "$completions" ]; then
        compadd -U -V unsorted -a completions
    fi
}

compdef _verdi_completion verdi;

