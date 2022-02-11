##=====================================================================
## Aliases
##=====================================================================

## cd
alias ..='cd  ..'
alias ...='cd  ../..'
alias ....='cd  ../../..'
alias .....='cd  ../../../..'
alias ......='cd  ../../../../..'
alias .......='cd  ../../../../..'

## ls
case ${OSTYPE} in
    # colored ls
    freebsd*|darwin*)
        if (( ${+commands[gls]} )); then
            # GNU coreutils installed
            alias ls='gls -Fa --color'
        else
            alias ls='ls -GFa'
        fi
        ;;
    linux*)
        alias ls='ls -Fa --color'
        ;;
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

## cp
alias cp="${ZSH_VERSION:+nocorrect} cp -i"

## mv
alias mv="${ZSH_VERSION:+nocorrect} mv -i"

## mkdir
alias mkdir="${ZSH_VERSION:+nocorrect} mkdir"

## grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

## zmv -- rename multiple files
alias zmv='noglob zmv -W'

## ps
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

## less
#alias less="$PAGER"
alias les="less"	# for typo

## sudo
#
# The first word of each simple command, if unquoted, is checked to see
# if it has an alias. [...] If the last character of the alias value is
# a space or tab character, then the next command word following the
# alias is also checked for alias expansion
#
case ${OSTYPE} in
    darwin*) alias sudo="${ZSH_VERSION:+nocorrect} sudo ";;
    linux*)  alias sudo='sudo '
esac

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

## tmux
# XDG compliancy fix for Tmux
alias tmux="tmux -f ${XDG_CONFIG_HOME}/tmux/tmux.conf"

## Vim
# alias vim="VIMINIT='let \$MYVIMRC=\"\$XDG_CONFIG_HOME/vim/vimrc\" | source \$MYVIMRC' vim"

# ----- End of file -----
# vim: foldmethod=marker
