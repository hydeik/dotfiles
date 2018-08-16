# has_command return true  if given name of command is exists
function has_command() {
    type "${1:?too few arguments}" &>/dev/null
}

# is_login returns true if current shell is running as the login shell
is_login() {
    [[ $SHLVL == 1 ]]
}

# is_git_repo returns true if cwd is in git repository
is_git_repo() {
    git rev-parse --is-inside-work-tree &>/dev/null
    return $status
}

# is_screen_running returns true if GNU screen is running
is_screen_running() {
    [[ -n $STY ]]
}

# is_tmux_runnning returns true if tmux is running
is_tmux_runnning() {
    [[ -n $TMUX ]]
}

# is_screen_or_tmux_running returns true if GNU screen or tmux is running
is_screen_or_tmux_running() {
    is_screen_running || is_tmux_runnning
}

# is_interactive returns true if the current shell is running from command line
is_interactive() {
    [[ -n $PS1 ]]
}

# is_ssh_running returns true if the ssh deamon is available
is_ssh_running() {
    [[ -n $SSH_CLIENT ]]
}

# ostype returns the lowercase OS name
ostype() {
    echo ${(L):-$(uname)}
}

# compile zsh scripts if modified.
zcompare() {
    if [[ -s "${1}" && ( ! -s "${1}.zwc" || "${1}" -nt "${1}.zwc") ]]; then
        zcompile "${1}"
    fi
}

# load file if exists
loadlib() {
    local f="${1:?'too few argument: you have to specify a file to source'}"
    if [[ -s "$f" ]]; then
        zcompare "$f"
        source "$f"
    fi
}

# re-compile zsh configuration files
zsh_reload () {
    zcompare "${ZDOTDIR}/.zshenv"
    zcompare "${ZDOTDIR}/.zshrc"
    for conf in ${ZDOTDIR}/rc/<->_*.zsh; do
        zcompare "${conf}"
    done
    if [[ -n "${ZPLUG_HOME}" ]]; then
        zcompare "${ZPLUG_HOME}/zcompdump"
    else
        zcompare "${ZDOTDIR:-$HOME}/.zcompdump"
    fi

    source "${ZDOTDIR}/.zshenv"
    source "${ZDOTDIR}/.zshrc"
}
