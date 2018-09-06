##======================================================================
## Function definitions
##======================================================================
##
## --- Zsh utility functions
##
# {{{
# Compile a given zsh script if modified.
function zcompare() {
    if [[ -s "${1}" && ( ! -s "${1}.zwc" || "${1}" -nt "${1}.zwc") ]]; then
        zcompile "${1}"
    fi
}

# Load file if exists. Compile the file before source it if necessary.
function loadlib() {
    local f="${1:?'too few argument: you have to specify a file to source'}"
    if [[ -s "$f" ]]; then
        zcompare "$f"
        source "$f"
    fi
}

# Show options set on current Zsh session
function showoptions() {
    set -o | sed -e 's/^no\(.*\)on$/\1  off/' -e 's/^no\(.*\)off$/\1  on/'
}

# Backup files and directories
function bak() {
    for i in $@ ; do
        if [[ -e $i.bak ]] || [[ -d $i.bak ]]; then
            echo "$i.bak already exist"
        else
            command cp -ir $i $i.bak
        fi
    done
}

#}}}

##
## --- Anyenv, pyenv, etc., extracted from $(anyenv init -)
##
#{{{

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

# # ndenv
# ndenv() {
#     typeset command
#     command="$1"
#     if [ "$#" -gt 0 ]; then
#         shift
#     fi
#
#     case "$command" in
#         rehash|shell|update)
#             eval "`ndenv "sh-$command" "$@"`";;
#         *)
#             command ndenv "$command" "$@";;
#     esac
# }

# nodenv
nodenv() {
    local command
    command="$1"
    if [ "$#" -gt 0 ]; then
        shift
    fi

    case "$command" in
        rehash|shell)
            eval "$(nodenv "sh-$command" "$@")";;
        *)
            command nodenv "$command" "$@";;
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
        activate|deactivate|rehash|shell|virtualenvwrapper|virtualenvwrapper_lazy)
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

#}}}

# ----- End of file -----
# vim: foldmethod=marker
