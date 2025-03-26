# -*- mode: zsh -*-
# vim: ft=zsh
##
## .zshenv --- Zsh configuration file
##

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

##============================================================================
## Environment variables
##============================================================================

# Detect home-manager's profile directory
HM_PROFILE_DIR="/etc/profiles/per-user/${USER}"
if [[ ! -d $HM_PROFILE_DIR ]]; then
    HM_PROFILE_DIR="${HOME}/.local/state/nix/profile"
fi
export HM_PROFILE_DIR

# Nix home-manager session variables
if [[ -r "${HM_PROFILE_DIR}/etc/profile.d/hm-session-vars.sh" ]]; then
    . "${HM_PROFILE_DIR}/etc/profile.d/hm-session-vars.sh"
fi

# Only source this once
if [[ -z "$__HM_ZSH_SESS_VARS_SOURCED" ]]; then
    export __HM_ZSH_SESS_VARS_SOURCED=1
    # Declare environment variables for zsh session here.

    # UID
    export UID

    # Language, Locale
    export LANGUAGE=en_US.UTF-8
    export LANG="${LANGUAGE}"
    export LC_ALL="${LANGUAGE}"
    export LC_CTYPE="${LANGUAGE}"

    # available $INTERACTIVE_FILTER
    export INTERACTIVE_FILTER="fzf:fzf-tmux:peco:percol:gof:pick"
fi

##==============================================================================
## System paths
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

## Call path_helper to set the system paths and manpaths (Darwin)
if [[ -x /usr/libexec/path_helper ]]; then
    eval $(/usr/libexec/path_helper -s)
fi

##  path / PATH
typeset -gxU path
path=(
    ${HOME}/bin(N-/)
    ${XDG_BIN_HOME}(N-/)
    # for OSX
    /Library/Tex/texbin(N-/)
    # *nix local
    /usr/local/cuda/bin(N-/)
    /usr/bin/x11(N-/)
    /usr/texbin(N-/)
    $path[@]
)

## fpath -- set before compinit
typeset -gxU fpath
fpath=(
    ${XDG_DATA_HOME}/zsh/site-functions(N-/)
    ${ZDOTDIR}/completions(N-/)
    ${ZDOTDIR}/functions(N-/)
    ${ZDOTDIR}/plugins/zsh-completions(N-/)
    /opt/homebrew/share/zsh/site-functions(N-/)
    #/usr/local/share/zsh/site-functions(N-/)
    $fpath[@]
)


## manpath / MANPATH
typeset -gxU manpath
manpath=(
    ${XDG_DATA_HOME}/man(N-/)
    /usr/local/cuda/doc/man(N-/)
    $manpath[@]
)

## infopath / INFOPATH
typeset -gxU  infopath INFOPATH
typeset -gxTU INFOPATH infopath  # tie the new array to the variables
infopath=(
    ${XDG_DATA_HOME}/info(N-/)
    # /usr/local/share/info(N-/)
    # /usr/share/info(N-/)
    $infopath[@]
)

## pag_config_path / PKG_CONFIG_PATH
typeset -gxU  pkg_config_path PKG_CONFIG_PATH
typeset -gxTU PKG_CONFIG_PATH pkg_config_path
pkg_config_path=(
    /opt/X11/lib/pkgconfig(N-/)
    /usr/local/lib/pkgconfig(N-/)
    /usr/local/share/pkgconfig(N-/)
    /usr/lib/x86_64-linux-gnu/pkgconfig(N-/)
    /usr/share/pkgconfig(N-/)
    /usr/lib/pkgconfig(N-/)
    $pkg_config_path[@]
)

##
## Load library path
##
[ -z "$ld_library_path" ] && typeset -gxT LD_LIBRARY_PATH ld_library_path
typeset -U ld_library_path
ld_library_path=(
    ${HOME}/lib(N-/)
    ${HOME}/opt/lib(N-/)
    ${XDG_LIB_HOME}(N-/)
    /usr/local/lib(N-/)
    /usr/local/lib32(N-/)
    /usr/local/cuda/lib64(N-)
    $ld_library_path[@]
)

##============================================================================
## Set package managers & development tools
##============================================================================
##
## Homebrew
##
case ${OSTYPE} in
    darwin*)
        case ${CPUTYPE} in
            arm64*)
                export HOMEBREW_PREFIX="/opt/homebrew"
                export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar"
                export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}"
                export HOMEBREW_FORCE_BREWED_CURL=1
                ;;
            x86_64*)
                export HOMEBREW_PREFIX="/usr/local"
                export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}"
                export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}/Homebrew"
                export HOMEBREW_FORCE_BREWED_CURL=1
                ;;
        esac
        ;;
    linux*gnu)
        export HOMEBREW_PREFIX="${HOME}/.linuxbrew"
	;;
    *)
        ;;
esac
path=(
    ${HOMEBREW_PREFIX}/bin(N-/)
    ${HOMEBREW_PREFIX}/sbin(N-/)
    ${HOMEBREW_PREFIX}/opt/curl/bin(N-/)
    ${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin(N-/)
    ${HOMEBREW_PREFIX}/opt/findutils/libexec/gnubin(N-/)
    ${HOMEBREW_PREFIX}/opt/gnu-sed/libexec/gnubin(N-/)
    ${HOMEBREW_PREFIX}/opt/gnu-tar/libexec/gnubin(N-/)
    ${HOMEBREW_PREFIX}/opt/grep/libexec/gnubin(N-/)
    ${HOMEBREW_PREFIX}/opt/llvm/bin(N-/)
    ${HOMEBREW_PREFIX}/opt/sqlite/bin(N-/)
    $path[@]
)
manpath=(
    ${HOMEBREW_PREFIX}/share/man(N-/)
    ${HOMEBREW_PREFIX}/opt/curl/share/man(N-/)
    ${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnuman(N-/)
    ${HOMEBREW_PREFIX}/opt/findutils/libexec/gnuman(N-/)
    ${HOMEBREW_PREFIX}/opt/gnu-sed/libexec/gnuman(N-/)
    ${HOMEBREW_PREFIX}/opt/gnu-tar/libexec/gnuman(N-/)
    ${HOMEBREW_PREFIX}/opt/grep/libexec/gnuman(N-/)
    $manpath[@]
)
infopath=(
    ${HOMEBREW_PREFIX}/share/info(N-/)
    $infopath[@]
)
pkg_config_path=(
    ${HOME}/.linuxbrew/lib/pkgconfig(N-/)
    $pkg_config_path[@]
)

##
## Nix
##
for p in ${(z)NIX_PROFILES}; do
    path=(
        ${p}/bin(N-/)
        $path[@]
    )
    # fpath=(
    #     ${p}/share/zsh/site-functions(N-/)
    #     ${p}/share/zsh/${ZSH_VERSION}/functions(N-/)
    #     ${p}/share/zsh/vendor-completions(N-/)
    #     $fpath[@]
    # )
    manpath=(
        ${p}/share/man(N-/)
        $manpath[@]
    )
    infopath=(
        ${p}/info(N-/)
        $infopath[@]
    )
done

##
## RubyGems
##
path=( ${GEM_HOME}/bin(N-/) $path[@] )

##
## Go
##
export GOPATH=${HOME}
# path=( ${GOPATH}/bin(N-/) $path[@] )

# ##
# ## Rust, cargo
# ##
# path=( ${HOME}/.cargo/bin(N-/) $path[@] )
# if (( ${+commands[rustc]} )); then
#     RUST_SYS_ROOT=""
#     case ${OSTYPE} in
#         darwin*)
#             RUST_SYS_ROOT=${HOME}/.rustup/toolchains/stable-${MACHTYPE}-apple-darwin
#             ;;
#         linux*gnu)
#             RUST_SYS_ROOT=${HOME}/.rustup/toolchains/stable-${MACHTYPE}-unknown-linux-gnu
#             ;;
#         # TODO: add setting for other architecture
#     esac
#     if [[ ! -x "$RUST_SYS_ROOT" ]]; then
#         export RUST_SRC_PATH="${RUST_SYS_ROOT}/lib/rustlib/src/rust/src"
#         # for cargo completion
#         fpath=( ${RUST_SYS_ROOT}/share/zsh/site-functions $fpath[@] )
#         manpath=( ${RUST_SYS_ROOT}/share/man $manpath[@] )
#     fi
# fi

##
## Intel OneAPI -- source on request
##
# if [[ -f /opt/intel/oneapi/setvars.sh ]]; then
#     source /opt/intel/oneapi/setvars.sh
# fi



##============================================================================
## Computational programs
##============================================================================

# ## rscat
# if [[ -z "${RSCATDIR}" ]]; then
#     case "${HOST}" in
#         freya*) export RSCATDIR="${HOME}/programs/rscat";;
#         saga*)  export RSCATDIR="${HOME}/programs/rscat";;
#              *) export RSCATDIR="${HOME}/src/local/rscat";;
#     esac
# fi
# [[ -r "${RSCATDIR}/rscatvars.sh" ]] && . "${RSCATDIR}/rscatvars.sh"


# # WIEN2k
# export WIENROOT=/usr/local/calc/wien2k/WIEN2k_051222-ifort9-mkl8-serial
# path=( ${WIENROOT}(N-/) $path[@] )
# export SCRATCH=./

## Quantum ESPRESSO
export ESPRESSO_PSEUDO="${HOME}/.local/share/quantum_espresso/SSSP_efficiency_pseudos"

##============================================================================
## Machine local enviriments if provided
##============================================================================
[[ -f "${ZDOTDIR:-$HOME}/.secret" ]] && "${ZDOTDIR:-$HOME}/.secret"
