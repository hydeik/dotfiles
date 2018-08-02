#
# Aliases
#

# common commands

alias ..='cd  ..'
alias ...='cd  ../..'
alias ....='cd  ../../..'
alias .....='cd  ../../../..'
alias ......='cd  ../../../../..'
alias .......='cd  ../../../../..'

case ${OSTYPE} in
    # colored ls
    freebsd*|darwin*) alias ls='ls -GFa';;
    linux*)           alias ls='ls -Fa --color';;
esac

alias ld='ls -ld'          # Show info about the directory
alias lla='ls -lAF'        # Show hidden all files
alias ll='ls -lF'          # Show long file information
alias la='ls -AF'          # Show hidden files
alias lx='ls -lXB'         # Sort by extension
alias lk='ls -lSr'         # Sort by size, biggest last
alias lc='ls -ltcr'        # Sort by and show change time, most recent last
alias lu='ls -ltur'        # Sort by and show access time, most recent last
alias lt='ls -ltr'         # Sort by date, most recent last
alias lr='ls -lR'          # Recursive ls

alias cp="${ZSH_VERSION:+nocorrect} cp -i"
alias mv="${ZSH_VERSION:+nocorrect} mv -i"
alias mkdir="${ZSH_VERSION:+nocorrect} mkdir"

alias du='du -h'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Trash-cli instead of rm
if which trash-put &>/dev/null; then
    alias rm=trash-put
fi

# zmv -- rename multiple files
# autoload -Uz zmv
alias zmv='noglob zmv -W'

alias psa='ps auxw'

# Display the the first 8 processes with highest CPU usage
function pst() {
    psa | head -n 1
    psa | sort -r -n +2 | grep -v "ps -auxww" | grep -v grep | head -n 8
}

# Display the the first 8 processes with highest memory usage
function psm() {
    psa | head -n 1
    psa | sort -r -n +3 | grep -v "ps -auxww" | grep -v grep | head -n 8
}

# GREP process
function psg() {
    psa | head -n 1
    psa | grep $* | grep -v "ps -auxww" | grep -v grep
}

#alias less="$PAGER"
alias les="less"	# for typo

# The first word of each simple command, if unquoted, is checked to see
# if it has an alias. [...] If the last character of the alias value is
# a space or tab character, then the next command word following the
# alias is also checked for alias expansion
case ${OSTYPE} in
    darwin*) alias sudo="${ZSH_VERSION:+nocorrect} sudo ";;
    linux*)  alias sudo='sudo '
esac

#### gnuplot with rlwrap
if (( ${+commands[rlwrap]} )); then
    alias gnuplot="rlwrap -a -c gnuplot"
fi

#### emacs
#if [ -x $HOME/bin/select-emacs ]; then
#    alias emacs='$HOME/bin/select-emacs'
#    alias emasc='$HOME/bin/select-emacs'
#fi

#### switch compiler
alias usegnu="CC=gcc CXX=g++ FC=g77"
alias useintel="CC=icc CXX=icpc FC=ifort F90=ifort"
alias usepgi="CC=pgcc CXX=pgCC FC=pgf77 F90=pgf90"

# functions/commands which are always executed background
function gv() { command gv $* & }
function gimp() { command gimp $* & }
function mozzila() { command mozilla $* & }
function xdvi() { command xdvi $* & }
function xpdf() { command xpdf $* & }
function evince() { command evince $* & }
function okular() { command okular $* & }
function acroread() { command acroread $* & }
function display() { command display $* & }
function mpg321() { command mpg321 -s $* | esdcat & }

# --- ranger CLI filer
# Prevent nested ranger instances
function ranger() {
    if [ -z "${RANGER_LEVEL}" ]; then
        command ranger $@
    else
        exit
    fi
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

# XDG compliancy fix for Tmux
alias tmux="tmux -f ${XDG_CONFIG_HOME}/tmux/tmux.conf"

#function emacs() {
#    gnuclient "$@" 2> /dev/null || command emacs "$@" 2> /dev/null &
#}
