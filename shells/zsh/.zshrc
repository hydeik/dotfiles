##
## .zshrc -- Zsh configuration file (for interactive mode)
##

# # Return if zsh is called from Vim
# if [[ -n $VIMRUNTIME ]]; then
#     return 0
# fi

## Tmux
# Attach tmux session automatically if exists, create new session otherwise.
if (( ${+commands[tmux]} )); then
    export TMUX_AUTO_START=true
    export PERCOL=fzf
    source ${ZDOTDIR}/scripts/tmux_auto.zsh
fi

##
## Utility functions for shell configuration
##
source "${ZDOTDIR}/scripts/utils.zsh"

##
## Zgen plugin manager
##
export ZGEN_DIR="${ZDOTDIR}/.zgen"
export ZGEN_INIT="${ZGEN_DIR}/init.zsh"
export ZGEN_CUSTOM_COMPDUMP="${XDG_CACHE_HOME}/zsh/zcompdump"

# Load zgen only if a user types a zgen command
zgen () {
    unset -f zgen
    if [[ ! -s "${ZGEN_DIR}/zgen.zsh" ]]; then
        git clone --recursive https://github.com/tarjoilija/zgen.git "${ZGEN_DIR}"
    fi
    source "${ZGEN_DIR}/zgen.zsh"
    zgen "$@"
}

# Generate zgen init script (cache) if needed
if [[ ! -s "${ZGEN_DIR}/init.zsh" ]]; then
    # plugins
    zgen load "greymd/tmux-xpanes"
    # zgen load "mollifier/anyframe"
    zgen load "junegunn/fzf"  "shell/key-bindings.zsh"
    zgen load "junegunn/fzf"  "shell/completion.zsh"
    zgen load "zsh-users/zsh-completions"
    zgen load "zsh-users/zsh-autosuggestions"
    zgen load "zdharma/fast-syntax-highlighting"
    zgen load "zsh-users/zsh-history-substring-search"

    # local configuration files
    for conf in ${ZDOTDIR}/rc/*.zsh; do
        zgen load "${conf}"
    done

    # generate $ZGEN_INIT file
    zgen save

    # Compile files if necessary
    zsh_compile_all
fi

source "${ZGEN_INIT}"

##
## Machine local settings
##
loadlib "${ZDOTDIR:-$HOME}/.zshrc_local"

##
## Profiling
##
#if type zprof > /dev/null 2>&1; then
#    zprof | less
#fi
