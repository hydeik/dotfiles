##
## rc/70_prompt.zsh -- customize Zsh prompt
##

# powerline-rs is fast!
if (( ${+commands[powerline-rs]} )); then
    function powerline_precmd() {
        PS1="$(powerline-rs --shell zsh $?)"
    }

    function install_powerline_precmd() {
        for s in "${precmd_functions[@]}"; do
            if [ "$s" = "powerline_precmd" ]; then
                return
            fi
        done
        precmd_functions+=(powerline_precmd)
    }

    if [ "${TERM}" != "linux" ]; then
        install_powerline_precmd
    fi
fi

## time
#
# Print execution statistics upon completion whenever a command takes more
# than $REPORTTIME sec.
#
REPORTTIME=5
# Customize print format
# TIMEFMT="\
#     The name of this job.             :%J
#     CPU seconds spent in user mode.   :%U
#     CPU seconds spent in kernel mode. :%S
#     Elapsed time in seconds.          :%E
#     The  CPU percentage.              :%P"

## Watching login/logout
# Watching other users
watch=(notme)
# Check every 60 seconds.
LOGCHECK=60
# Format message printed on login/logout
WATCHFMT="%(a:${fg[blue]}Hello %n [%m] [%t]:${fg[red]}Bye %n [%m] [%t])"
