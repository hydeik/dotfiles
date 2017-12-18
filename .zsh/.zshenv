#
# Setting for profiling `zplof`
#
# zmodload zsh/zprof && zprof

##
## HTTP proxy (if necessary)
##
# export http_proxy=
# export ftp_proxy=
# export RSYNC_PROXY=

##==============================================================================
## Increase stack size (required for large scale simulation on linux)
##==============================================================================
case ${OSTYPE} in
    darwin*) ulimit -s unlimited ;;
    linux*)  ulimit -s unlimited ;;
esac

##==============================================================================
## Set path environment
##==============================================================================
#
# Note:
#   A file path with (N) flag is expanded empty string if not exist.
#
#   typeset
#     -g global flag
#     -x declare as a variable
#     -U list_name removes duplicated element in the list.
#

## fpath -- set before compinit
typeset -gxU fpath
fpath=(
    $HOME/.zsh/Completion(N-/)
    $HOME/.zsh/functions(N-/)
    $HOME/.zsh/plugins/zsh-completions(N-/)
    /usr/local/share/zsh/site-functions(N-/)
    $fpath[@]
)

##  path / PATH
typeset -gxU path
path=(
    $HOME/bin(N-/)
    $HOME/bin(N-/)
    # for OSX
    /Library/Tex/texbin(N-/)
    # *nix local, HomeBrew
    /usr/local/bin(N-/)
    /usr/local/sbin(N-/)
    # MacPorts
    /opt/local/bin(N-/)
    # System
    /usr/bin(N-/)
    /usr/sbin(N-/)
    /usr/x11{6,7}/bin(N-/)
    /usr/bin/x11(N-/)
    /usr/i18n/bin(N-/)
    /usr/kerberos/bin(N-/)
    /usr/kerberos/sbin(N-/)
    /bin(N-/)
    /sbin(N-/)
    /usr/texbin(N-/)
    $path[@]
)

## manpath / MANPATH
typeset -gxU manpath
manpath=(
    $HOME/man(N-/)
    $HOME/dev/man(N-/)
    /sw/share/man(N-/)
    /opt/local/share/man(N-/)
    /usr/local/share/jman(N-/)
    /usr/local/share/man/ja(N-/)
    /usr/local/share/man(N-/)
    /usr/share/man/ja(N-/)
    /usr/share/man(N-/)
    $manpath[@]
)

## infopath / INFOPATH
typeset -gxU infopath INFOPATH
typeset -gxTU INFOPATH infopath  # tie the new array to the variables

infopath=(
    $HOME/share/info(N-/)
    $HOME/dev/share/info(N-/)
    /usr/local/share/info(N-/)
    /usr/share/info(N-/)
    $infopath[@]
)

## pag_config_path / PKG_CONFIG_PATH
typeset -gxU pkg_config_path PKG_CONFIG_PATH
typeset -gxU PKG_CONFIG_PATH pkg_config_path

pkg_config_path=(
    $HOME/.linuxbrew/lib/pkgconfig(N-/)
    /usr/local/lib/pkgconfig(N-/)
    /usr/lib/x86_64-linux-gnu/pkgconfig(N-/)
    /usr/share/pkgconfig(N-/)
    /usr/lib/pkgconfig(N-/)
    /opt/X11/lib/pkgconfig(N-/)
    $pkg_config_path[@]
)

##
## Load library path
##
[ -z "$ld_library_path" ] && typeset -gxT LD_LIBRARY_PATH ld_library_path
typeset -U ld_library_path
ld_library_path=(
    $HOME/lib(N-/)
    $HOME/opt/oski/lib/oski(N-/)
    $HOME/opt/lib(N-/)
    /opt/gotoblas(N-/)
    /usr/local/lib(N-/)
    /usr/local/lib32(N-/)
    /usr/local/calc/openmpi/lib(N-/)
    /usr/local/calc/lam/lib(N-/)
    $ld_library_path[@]
)

##
## HOST
##
if (( ${+commands[hostname]} )); then
    export HOST=`hostname`
fi;
export host=`echo $HOST | sed -e 's/\..*//'`

export UID
SHELL=`which zsh`; export SHELL

##
## Language, Locale
##
export LANGUAGE=en_US.UTF-8
export LANG=${LANGUAGE}
export LC_ALL=${LANGUAGE}
export LC_CTYPE=${LANGUAGE}

##
## History
##
# History file
export HISTFILE=${ZDOTDIR}/.zsh_history
# History size in memory
export HISTSIZE=100000
# The number of histsize
export SAVEHIST=1000000
# The size of asking history
export LISTMAX=50
# Do not add in root
if [[ $UID == 0 ]]; then
    unset HISTFILE
    export SAVEHIST=0
fi


#### PAGER
export PAGER=less

# Less status line
export LESS='-R -f -X -i -P ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'
export LESSCHARSET='utf-8'

# LESS man page colors (makes Man pages more readable).
# Source: http://unix.stackexchange.com/a/147
# More info: http://unix.stackexchange.com/a/108840
if [[ -n $TERM ]]; then
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
fi

# Colors for ls
## for GNU ls
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
## for BSD, OSX
export LSCOLORS=exfxcxdxbxegedabagacad

#### EDITOR
if (( ${+commands[vim]} )); then  
    export EDITOR="vim"
else
    export EDITOR="vi"
fi

#### $COLORTERM 
export COLORTERM=0
case "$TERM" in 
    kterm*);    COLORTERM=1 ;;
    xterm*);    COLORTERM=1 ;;
    rxvt*);     COLORTERM=1 ;;
    mlterm*);   COLORTERM=1 ;;
    Eterm*);    COLORTERM=1 ;;
    screen*);   COLORTERM=1 ;;
    eterm*);    COLORTERM=1 ;;  # eterm on GNU Emacs
    dumb*);     COLORTERM=0 ;;  #
    # emacs*);  COLORTERM=1 ;;
    ct100*);    COLORTERM=1 ;;  # TeraTermPro
esac

##
## Development environment
##

# Python
export WORKON_HOME=${HOME}/.virtualenv

# pyenv -- Python environment
# export PYENV_ROOT=${HOME}/.pyenv
# path=( ${PYENV_ROOT}/bin(N-/) $path[@] )
# eval "$(pyenv init - --no-rehash)"

# Rust
path=( ${HOME}/.cargo/bin(N-/) $path[@] )
if (( ${+commands[rustc]} )); then
    export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

# Golang
export GOPATH=${HOME}

##
## Intel C/C++, Intel Fortran, and MKL
##
#if [[ $ARCHI == "linux" ]]; then
#    # For Intel Compiler Suite
#    INTEL_CMP_DIR=/opt/intel/Compiler/13.1/072
#    case "$MACHTYPE" in
#       x86_64*)   INTEL_ARCH="intel64";;
#       i*86*)     INTEL_ARCH="ia32";;
#           *)     INTEL_ARCH= ;
#    esac
#    if [[ -x $INTEL_CMP_DIR/bin/iccvars.sh ]] && test ! `echo $PATH | ${GREP} -q ${INTEL_CMP_DIR}/bin/${INTEL_ARCH}` ; then
#        source $INTEL_CMP_DIR/bin/iccvars.sh ${INTEL_ARCH}
#    fi
#    unset INTEL_CMP_DIR INTEL_ARCH
#fi

#if [[ $ARCHI == "linux" ]] || [[ $ARCHI == "darwin" ]]; then
#    # For Intel Compiler Suite
#    INTEL_CMP_DIR=/opt/intel/composerxe
#    MKL_INTERFACE="lp64"
#    # case "$MACHTYPE" in
#    #    x86_64*)   INTEL_ARCH="intel64";;
#    #    i*86*)     INTEL_ARCH="ia32";;
#    #        *)     INTEL_ARCH= ;
#    # esac
#    INTEL_ARCH="intel64"
#    if [[ -f $INTEL_CMP_DIR/bin/compilervars.sh ]] ; then
#        source $INTEL_CMP_DIR/bin/compilervars.sh ${INTEL_ARCH} ${MKL_INTERFACE}
#    fi
#    unset INTEL_CMP_DIR INTEL_ARCH MKL_INTERFACE
#fi

##
## Computational programs
##

# rscat
if [[ -z $RSCATDIR ]]; then
  case "$HOST" in
      freya*) export RSCATDIR=$HOME/programs/rscat;;
      saga*)  export RSCATDIR=$HOME/programs/rscat;;
           *) export RSCATDIR=$HOME/program/rscat;;
  esac
fi
[[ -r $RSCATDIR/rscatvars.sh ]] && . $RSCATDIR/rscatvars.sh


# WIEN2k
export WIENROOT=/usr/local/calc/wien2k/WIEN2k_051222-ifort9-mkl8-serial
path=( ${WIENROOT}(N-/) $path[@] )
export SCRATCH=./

# ADF
#export ADFHOME=/Applications/adf2010.02/adfhome
#export ADFHOME=${HOME}/opt/adfhome
#export ADFHOME=${HOME}/program/adf-mybranch
export ADFROOT=${HOME}/opt/adf2012.01/adfhome
[[ -f ${ADFROOT}/adfrc.sh ]] && . ${ADFROOT}/adfrc.sh

# available $INTERACTIVE_FILTER
export INTERACTIVE_FILTER="fzf:peco:percol:gof:pick"

#
# Machine local configurations
#
[[ -f ~/.secret ]] && source ~/.secret

