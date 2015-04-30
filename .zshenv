# -*- mode: sh; coding: utf-8-unix; indent-tabs-mode: nil -*-
##
## File ~/.zshenv
## Set the environment variables for zsh.
##

##
## Load system environment variables
##
if [[ -e /etc/profile.env ]]; then
    source /etc/profile.env
fi

##
## HTTP proxy (if necessary)
##
# export http_proxy=
# export ftp_proxy=
# export RSYNC_PROXY=

##==============================================================================
## Set path environment
##==============================================================================
#
# Note:
#   A file path with (N) flag is expanded empty string if not exist.
#   typeset -U list_name removes duplicated element in the list.
#

##  path / PATH
typeset -U path
path=(
    $HOME/bin(N)
    $HOME/opt/sage(N)
    # MacPorts
    /opt/local/bin(N)
    # Fink
    /sw/bin(N)
    # *nix local, HomeBrew
    /usr/local/bin(N)
    /usr/local/sbin(N)
    # System
    /bin(N)
    /sbin(N)
    /usr/bin(N)
    /usr/sbin(N)
    /usr/texbin(N)
    /usr/x11{6,7}/bin(N)
    /usr/bin/x11(N)
    /usr/i18n/bin(N)
    /usr/kerberos/bin(N)
    /usr/kerberos/sbin(N)
    $path[@]
)

## manpath / MANPATH
typeset -U manpath
manpath=(
    $HOME/man(N)
    /sw/share/man(N)
    /opt/local/share/man(N)
    /usr/local/share/jman(N)
    /usr/local/share/man/ja(N)
    /usr/local/share/man(N)
    /usr/share/man/ja(N)
    /usr/share/man
    $manpath[@]
)


##
## Info path
##
# if [[ -z $INFOPATH ]]; then
#     INFOPATH=$HOME/info
# else
#     INFOPATH=$HOME/info:$INFOPATH
# fi
# export INFOPATH

##
## Load library path
##
[ -z "$ld_library_path" ] && typeset -xT LD_LIBRARY_PATH ld_library_path
typeset -U ld_library_path
ld_library_path=(
    $HOME/lib(N)
    $HOME/opt/oski/lib/oski(N)
    $HOME/opt/lib(N)
    /opt/gotoblas(N)
    /usr/local/lib(N)
    /usr/local/lib32(N)
    /usr/local/calc/openmpi/lib(N)
    /usr/local/calc/lam/lib(N)
    $ld_library_path[@]
)

##
## ARCHI
##
if [[ -x `which uname` ]]; then
    case "`uname -sr`" in 
        FreeBSD*); export ARCHI="freebsd" ;;
        Linux*);   export ARCHI="linux" ;;
        CYGWIN*);  export ARCHI="cygwin" ;; # Windows
	Darwin*);  export ARCHI="darwin" ;; # Mac OS
        *);        export ARCHI="dummy" ;;
    esac
else
    export ARCHI="dummy"
fi

##
## HOST
##
if [ -x /bin/hostname ] || [ -x /usr/bin/hostname ]; then
    export HOST=`hostname`
fi;
export host=`echo $HOST | sed -e 's/\..*//'`

export UID
SHELL=`which zsh`; export SHELL

##
## Language, Locale
##
if [[ $ARCHI == "cygwin" ]]; then
    export LC_ALL="ja"
    export LANG="ja"
else
    case "$HOST" in
        freya*) export LC_ALL="ja_JP.UTF-8"; \
                export LANG="ja_JP.UTF-8";;
        loki*)  export LC_ALL="ja_JP.UTF-8"; \
                export LANG="ja_JP.UTF-8";;
        *)      export LC_ALL="C"; \
                export LANG="C";;
    esac
fi
if [[ $ARCHI == "cygwin" ]]; then
    export JLESSCHARSET="japanese-sjis"
else
    export JLESSCHARSET="japanese"
fi


#### PAGER
for cmd in lv w3m less more ; do
    if [[ -x `which $cmd` ]] ; then 
        pager=$cmd
        break
    fi
done
case "$pager" in
    lv)   export PAGER="lv -c"; export MANPAGER="lv -c";;
    # less -M: show page status
    less) export PAGER="less -M"; export MANPAGER="less -M";;
    *)    export PAGER=$pager; export MANPAGER=$pager;;
esac
unset pager cmd

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

#### EDITOR
if [[ -x `where vim`  ]]; then  
    export EDITOR="vim"
else
    export EDITOR="vi"
fi

##
## Python
##
[ -z "$pythonpath" ] && typeset -xT PYTHONPATH pythonpath
typeset -U pythonpath
pythonpath=(
    #$HOME/python/lib/python2.7/site-packages
    $HOME/python/lib/python3.4/site-packages
    $HOME/lib/python
    $HOME/opt/ase
    /usr/local/lib/python3.4/site-packages
    $pythonpath[@]
    )

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


## Computational programs

# rscat
if [[ -z $RSCATDIR ]]; then
  case "$HOST" in
      freya*) export RSCATDIR=$HOME/programs/rscat;;
      saga*)  export RSCATDIR=$HOME/programs/rscat;;
           *) export RSCATDIR=$HOME/program/rscat;;
  esac
fi
 
if [[ -r $RSCATDIR/rscatvars.sh ]]; then
    source $RSCATDIR/rscatvars.sh
fi

# WIEN2k
export WIENROOT=/usr/local/calc/wien2k/WIEN2k_051222-ifort9-mkl8-serial
if [[ -d $WIENROOT ]] && test ! `echo $PATH | ${GREP} -q $WIENROOT` ; then
    export PATH=$WIENROOT:$PATH
fi
export SCRATCH=./

# GPAW
export GPAW_SETUP_PATH=${HOME}/share/gpaw/gpaw-setups-0.5.3574

# p4vasp
export P4VASP_HOME=$HOME/opt/p4vasp
if [[ -d $P4VASP_HOME ]] && test ! `echo $PYTHONPATH | ${GREP} -q $P4VASP_HOME/python-packages` ; then
    export PYTHONPATH=$PYTHONPATH:$P4VASP_HOME/python-packages
fi
if [[ -d $P4VASP_HOME ]] && test ! `echo $PATH | ${GREP} -q $P4VASP_HOME` ; then
    export PATH=$PATH:$P4VASP_HOME/bin
fi

# XcrysDen
export XCRYSDEN_TOPDIR=${HOME}/opt/XCrySDen-1.5.60
export XCRYSDEN_SCRATCH=${XCRYSDEN_TOPDIR}/tmp

# ORCA
ORCAROOT=${HOME}/opt/orca_amd64_exe
if [[ -d $ORCAROOT ]] && test ! `echo $PATH | ${GREP} -q $ORCAROOT` ; then
    export PATH=${ORCAROOT}:$PATH
fi

# exciting
export EXCITINGROOT=${HOME}/opt/exciting
#export EXCITINGROOT=${HOME}/opt/exciting-devel
    
# ADF
#export ADFHOME=/Applications/adf2010.02/adfhome
#export ADFHOME=${HOME}/opt/adfhome
#export ADFHOME=${HOME}/program/adf-mybranch
ADFROOT=${HOME}/opt/adf2012.01/adfhome
if [ -e "${ADFROOT}/adfrc.sh" ]; then
    source ${ADFROOT}/adfrc.sh 
fi

### End of file; ###
