## .zshenv --- Zsh configuration file

##
## NOTE: Zsh configuration file loading order
##

# -- login shell
# 1. /etc/zshenv
# 2. ${ZDOTDIR}/.zshenv
# 3. /etc/zprofile
# 4. ${ZDOTDIR}/.zprofile
# 5. /etc/zshrc
# 6. ${ZDOTDIR}/.zshrc
# 7. /etc/zlogin
# 8. ${ZDOTDIR}/.zlogin

# -- interactive shell
# 1. /etc/zshenv
# 2. ${ZDOTDIR}/.zshenv
# 3. /etc/zshrc
# 4. ${ZDOTDIR}/.zshrc

# -- shell script (non-interactive)
# 1. /etc/zshenv
# 2. ${ZDOTDIR}/.zshenv

# -- logout
# 1. ${ZDOTDIR}/.zlogout
# 2. /etc/zlogout

##
## Setting for profiling `zplof`
##
if [[ -z "$PROFILE_STARTUP" ]]; then
    PROFILE_STARUP=false
fi
if [[ "$PROFILE_STARTUP" == true ]]; then
    # zmodload zsh/zprof && zprof
    zmodload zsh/datetime
    PS4='+$EPOCHREALTIME %N:%i> '

    logfile=$(mktemp zsh_profile.XXXXXXXX)
    echo "Logging to $logfile"
    exec 3>&2 2>$logfile
    setopt prompt_subst xtrace
fi

##==============================================================================
## System configuration
##==============================================================================

##
## Prevent to load system provided configuration files:
##  - /etc/zprofile
##  - /etc/zshrc
##  - /etc/zlogin
##  - /etc/zlogout
##

unsetopt global_rcs

##
## Increase stack size (required for large scale simulation on linux)
##
case ${OSTYPE} in
    darwin*) ulimit -s unlimited ;;
    linux*)  ulimit -s unlimited ;;
esac
##
## Set the default permission of file to 0644 (rw-r--r--)
##
umask 022
##
## Do not dump `core` file
##
limit coredumpsize 0

## HOST
export HOST=$(uname -n)

## UID
export UID

##
## Language, Locale
##
export LANGUAGE=en_US.UTF-8
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

##==============================================================================
## XDG Base Directory Specification
##==============================================================================
# --- User directories
export XDG_CONFIG_HOME="${HOME}/.config"     # [default: $HOME/.config]
export XDG_CACHE_HOME="${HOME}/.cache"       # [default: $HOME/.cache]
export XDG_DATA_HOME="${HOME}/.local/share"  # [default: $HOME/.local/share]
export XDG_BIN_HOME="${HOME}/.local/bin"
export XDG_LIB_HOME="${HOME}/.local/lib"
# export XDG_RUNTIME_DIR                     # [default: ?]

# --- System directories
## [default: /usr/local/share:/usr/share]
#export XDG_DATA_DIRS=/usr/local/share:/usr/share
## [default: /etc/xdg]
#export XDG_CONFIG_DIRS=/etc/xdg

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
    ${XDG_DATA_HOME}/zsh/site-functions(N-/)
    ${ZDOTDIR}/completions(N-/)
    ${ZDOTDIR}/functions(N-/)
    ${ZDOTDIR}/plugins/zsh-completions(N-/)
    /usr/local/share/zsh/site-functions(N-/)
    $fpath[@]
)

##  path / PATH
typeset -gxU path
path=(
    ${HOME}/bin(N-/)
    # $HOME/.local/bin(N-/) # for pip --user
    ${XDG_BIN_HOME}(N-/)
    # Yarn bin dir (set by `yarn config set prefix $HOME/.yarn`)
    ${HOME}/.yarn/bin
    # for OSX
    /Library/Tex/texbin(N-/)
    # for OSX, GNU commands installed with Homebrew
    /usr/local/opt/coreutils/libexec/gnubin(N-/)
    /usr/local/opt/findutils/libexec/gnubin(N-/)
    /usr/local/opt/gnu-sed/libexec/gnubin(N-/)
    /usr/local/opt/gnu-tar/libexec/gnubin(N-/)
    /usr/local/opt/grep/libexec/gnubin(N-/)
    # *nix local, Homebrew
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
    ${HOME}/man(N-/)
    ${HOME}/dev/man(N-/)
    ${XDG_DATA_HOME}/man(N-/)
    /usr/local/opt/coreutils/libexec/gnuman(N-/)
    /usr/local/opt/findutils/libexec/gnuman(N-/)
    /usr/local/opt/gnu-sed/libexec/gnuman(N-/)
    /usr/local/opt/gnu-tar/libexec/gnuman(N-/)
    /usr/local/opt/grep/libexec/gnuman(N-/)
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
typeset -gxU  infopath INFOPATH
typeset -gxTU INFOPATH infopath  # tie the new array to the variables
infopath=(
    ${HOME}/share/info(N-/)
    ${HOME}/dev/share/info(N-/)
    ${XDG_DATA_HOME}/info(N-/)
    /usr/local/share/info(N-/)
    /usr/share/info(N-/)
    $infopath[@]
)

## pag_config_path / PKG_CONFIG_PATH
typeset -gxU  pkg_config_path PKG_CONFIG_PATH
typeset -gxTU PKG_CONFIG_PATH pkg_config_path
pkg_config_path=(
    ${HOME}/.linuxbrew/lib/pkgconfig(N-/)
    /usr/local/lib/pkgconfig(N-/)
    /usr/local/share/pkgconfig(N-/)
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
    ${HOME}/lib(N-/)
    ${HOME}/opt/oski/lib/oski(N-/)
    ${HOME}/opt/lib(N-/)
    ${XDG_LIB_HOME}(N-/)
    /opt/gotoblas(N-/)
    /usr/local/lib(N-/)
    /usr/local/lib32(N-/)
    /usr/local/calc/openmpi/lib(N-/)
    /usr/local/calc/lam/lib(N-/)
    $ld_library_path[@]
)

##============================================================================
## Other environment variables
##============================================================================
##
## Pager
##
export PAGER=less

##
## EDITOR
##
if (( ${+commands[nvim]} )); then
    export EDITOR="nvim"
elif (( ${+commands[vim]} )); then
    export EDITOR="vim"
else
    export EDITOR="vi"
fi
export VISUAL="${EDITOR}"

##============================================================================
## Development environment
##============================================================================

##
## Anyenv (for python, ruby, Go, Node.js)
##
#
# NOTE:
#
# `eval $(anyenv init -)` slows down shell startup significantly.
# if (( ${+commands[anyenv]} )); then
#     eval "$(anyenv init - --no-rehash)"
# fi
#
# Thus, the environment variables defined in the output of `$(anyenv init -)`
# are manually expanded here, and the funcions generated by the above command
# are also defined in rc/20_development.zsh.
#
# Add variables if you want to enable other **env.
export ANYENV_ROOT="${HOME}/.anyenv"
export GOENV_ROOT="${ANYENV_ROOT}/envs/goenv"
export NODENV_ROOT="${ANYENV_ROOT}/envs/nodenv"
export PYENV_ROOT="${ANYENV_ROOT}/envs/pyenv"
export RBENV_ROOT="${ANYENV_ROOT}/envs/rbenv"
export GOENV_SHELL="${SHELL}"
export NODENV_SHELL="${SHELL}"
export PYENV_SHELL="${SHELL}"
export RBENV_SHELL="${SHELL}"
path=(
    ${ANYENV_ROOT}/bin(N-/)
    ${GOENV_ROOT}/bin(N-/)
    ${GOENV_ROOT}/shims(N-/)
    ${NODENV_ROOT}/bin(N-/)
    ${NODENV_ROOT}/shims(N-/)
    ${PYENV_ROOT}/bin(N-/)
    ${PYENV_ROOT}/shims(N-/)
    ${RBENV_ROOT}/bin(N-/)
    ${RBENV_ROOT}/shims(N-/)
    $path[@]
)

export PYENV_VIRTUALENV_DISABLE_PROMPT=1

##
## Pipenv
##
export PIPENV_CACHE_DIR="${XDG_CACHE_HOME}/pipenv"
export PIPENV_VENV_IN_PROJECT=1

##
## IPython
##
export IPYTHONDIR="${XDG_CONFIG_HOME}/ipython"

##
## Jupyter
##
export JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME}/jupyter"
export JUPYTER_DATA_DIR="${XDG_DATA_HOME}/jupyter"
typeset -gxU  jupyter_path JUPYTER_PATH
typeset -gxTU JUPYTER_PATH jupyter_path
jupyter_path=(
    ${JUPYTER_DATA_DIR}(N-/)
    ${PYENV_ROOT}/versions/jupyter3/share/jupyter(N-/)
    /usr/local/share/jupyter(N-/)
    /usr/share/jupyter(N-/)
    $jupyter_path[@]
)

##
## RubyGems
##
export GEM_HOME=${XDG_DATA_HOME}/gem
export GEM_SPEC_CACHE=${XDG_CACHE_HOME}/gem

##
## Rust
##
path=( ${HOME}/.cargo/bin(N-/) $path[@] )
if (( ${+commands[rustc]} )); then
    RUST_SYS_ROOT=""
    case ${OSTYPE} in
        darwin*)
            RUST_SYS_ROOT=${HOME}/.rustup/toolchains/stable-${MACHTYPE}-apple-darwin
            ;;
        linux*gnu)
            RUST_SYS_ROOT=${HOME}/.rustup/toolchains/stable-${MACHTYPE}-unknown-linux-gnu
            ;;
        # TODO: add setting for other architecture
    esac
    if [[ "x$RUST_SYS_ROOT" != "x" ]]; then
        export RUST_SRC_PATH="${RUST_SYS_ROOT}/lib/rustlib/src/rust/src"
        # for cargo completion
        fpath=( ${RUST_SYS_ROOT}/share/zsh/site-functions $fpath[@] )
        manpath=( ${RUST_SYS_ROOT}/share/man $manpath[@] )
    fi
fi

##
## Go
##
export GOPATH=${HOME}
# path=( ${GOPATH}/bin(N-/) $path[@] )

##
## Intel C/C++, Intel Fortran, and MKL
##
case ${OSTYPE} in
    linux*)
        case "${MACHTYPE}" in
            x86_64*)   INTEL_ARCH="intel64";;
            i*86*)     INTEL_ARCH="ia32";;
                *)     INTEL_ARCH= ;;
        esac
        INTEL_COMPILER_DIR=/opt/intel/compilers_and_libraries
        if [[ -f ${INTEL_COMPILER_DIR}/linux/bin/compilervars.sh ]]; then
            . ${INTEL_COMPILER_DIR}/linux/bin/compilervars.sh ${INTEL_ARCH}
        fi
        unset INTEL_COMPILER_DIR INTEL_ARCH
        ;;
    *)  ;;
esac

##
## Tig
##
export TIGRC_USER=${XDG_CONFIG_HOME}/tig/config

##============================================================================
## Computational programs
##============================================================================

## rscat
if [[ -z "${RSCATDIR}" ]]; then
    case "${HOST}" in
        freya*) export RSCATDIR="${HOME}/programs/rscat";;
        saga*)  export RSCATDIR="${HOME}/programs/rscat";;
             *) export RSCATDIR="${HOME}/src/local/rscat";;
    esac
fi
[[ -r "${RSCATDIR}/rscatvars.sh" ]] && . "${RSCATDIR}/rscatvars.sh"


# # WIEN2k
# export WIENROOT=/usr/local/calc/wien2k/WIEN2k_051222-ifort9-mkl8-serial
# path=( ${WIENROOT}(N-/) $path[@] )
# export SCRATCH=./

# available $INTERACTIVE_FILTER
export INTERACTIVE_FILTER="fzf:fzf-tmux:peco:percol:gof:pick"

##============================================================================
## Machine local enviriments if provided
##============================================================================
[[ -f "${ZDOTDIR:-$HOME}/.secret" ]] && "${ZDOTDIR:-$HOME}/.secret"
