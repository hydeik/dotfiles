## -*- mode: sh; coding: euc-jp -*-
##
## File .zshenv
## Set the environment variables for zsh.
## Last modified: <2004/05/15 20:45:34 土曜日>

######## 環境変数 ########

##
## Load system environment variables
##
if [[ -e /etc/profile.env ]]; then
    source /etc/profile.env
fi

##
## HTTP proxy (if necessary)
##

# KUINS-III (Kyoto Univ)
# export http_proxy=http://proxy.kuins.net:8080/
# export ftp_proxy=ftp-proxy.kuins.net
# export RSYNC_PROXY=proxy.kuins.net:8080

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
    /usr/local/calc/openmpi/bin(N)
    /usr/local/share/python
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
    #$path[@]
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
## 入力ロケール
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
# less -M はページのステータス(何ページ目か)の表示
for cmd in lv w3m less more ; do
    if [[ -x `which $cmd` ]] ; then 
        pager=$cmd
        break
    fi
done
case "$pager" in
    lv)   export PAGER="lv -c"; export MANPAGER="lv -c";;
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
## Ruby
##
# export RUBYOPT='-Ke -rkconv'    # Ruby に渡すデフォルトオプション
if [[ -x `which gem` ]]; then
    export RUBYOPT=rubygems    # Ruby に渡すデフォルトオプション
    export PATH=/var/lib/gems/1.8/bin:$PATH
fi
export RUBYPATH=$HOME/ruby:/var/lib/gems/1.8/       # Ruby スクリプト探索PATH(追加)
export RUBYLIB=$HOME/ruby/lib:/usr/lib/ruby/gems/1.8    # Ruby ライブラリの探索パス(追加)

##
## Python
##
[ -z "$pythonpath" ] && typeset -xT PYTHONPATH pythonpath
typeset -U pythonpath
pythonpath=(
    $HOME/python
    $HOME/lib/python
    $HOME/opt/ase
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


## PETSc and SLEPc
export PETSC_DIR=$HOME/opt/petsc
export SLEPC_DIR=$HOME/opt/slepc

## Computational programs

#  rel_multiplet
# if [[ -d $HOME/program/rel_multiplet/bin ]] && test ! `echo $PATH | ${GREP} -q $HOME/program/rel_multiplet/bin` ; then
#     export PATH=$HOME/program/rel_multiplet/bin:$PATH
# fi

# rscat
if [[ -z $RSCATDIR ]]; then
  case "$HOST" in
      freya*) export RSCATDIR=$HOME/program/rscat;;
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
export XCRYSDEN_TOPDIR=${HOME}/opt/XCrySDen-1.5.21-bin-semishared
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
# export ADFHOME=${HOME}/opt/adf2012.01/adfhome
# export ADFBIN=$ADFHOME/bin
# export ADFRESOURCES=$ADFHOME/atomicdata
# export SCMLICENSE=${HOME}/opt/adf2012.01/license.txt
# export SCM_TMPDIR=/var/tmp

## # End of file; ###
