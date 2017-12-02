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

# re-compile zsh configuration files
function src() {
    autoload -U zrecompile
    [[ -f ${ZDOTDIR}/.zshenv ]] && zrecompile -p ${ZDOTDIR}/.zshenv
    [[ -f ${ZDOTDIR}/.zshrc ]] && zrecompile -p ${ZDOTDIR}/.zshrc
    [[ -f ${ZPLUG_HOME}/zcompdump ]] && zrecompile -p -M ${ZPLUG_HOME}/zcompdump
}
