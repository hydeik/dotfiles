# --- Anyenv

# anyenv
anyenv() {
    typeset command
    command="$1"
    if [ "$#" -gt 0 ]; then
        shift
    fi
    command anyenv "$command" "$@"
}

# goenv
goenv() {
    local command
    command="$1"
    if [ "$#" -gt 0 ]; then
        shift
    fi

    case "$command" in
        rehash|shell)
            eval "$(goenv "sh-$command" "$@")";;
        *)
            command goenv "$command" "$@";;
    esac
}

# ndenv
ndenv() {
    typeset command
    command="$1"
    if [ "$#" -gt 0 ]; then
        shift
    fi

    case "$command" in
        rehash|shell|update)
            eval "`ndenv "sh-$command" "$@"`";;
        *)
            command ndenv "$command" "$@";;
    esac
}

# pyenv
pyenv() {
    local command
    command="${1:-}"
    if [ "$#" -gt 0 ]; then
        shift
    fi

    case "$command" in
        activate|deactivate|rehash|shell)
            eval "$(pyenv "sh-$command" "$@")";;
        *)
            command pyenv "$command" "$@";;
    esac
}

# rbenv
rbenv() {
    local command
    command="${1:-}"
    if [ "$#" -gt 0 ]; then
        shift
    fi

    case "$command" in
        rehash|shell|update)
            eval "$(rbenv "sh-$command" "$@")";;
        *)
            command rbenv "$command" "$@";;
    esac
}

