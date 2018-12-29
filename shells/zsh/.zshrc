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

##======================================================================
## Plugins
##======================================================================
##
## Zgen plugin manager
##
export ZGEN_DIR="${ZDOTDIR}/.zgen"
export ZGEN_INIT="${ZGEN_DIR}/init.zsh"
#export ZGEN_CUSTOM_COMPDUMP="${XDG_CACHE_HOME}/zsh/zcompdump"
# compinit is called manually.
export ZGEN_AUTOLOAD_COMPINIT=0

# Load zgen only if a user types a zgen command
zgen () {
    unset -f zgen
    if [[ ! -s "${ZGEN_DIR}/zgen.zsh" ]]; then
        git clone --recursive https://github.com/tarjoilija/zgen.git "${ZGEN_DIR}"
    fi
    source "${ZGEN_DIR}/zgen.zsh"
    zgen "$@"
}

# Compile zsh configurations and scripts
zsh_compile_all() {
    zcompare "${ZDOTDIR}/.zshenv"
    zcompare "${ZDOTDIR}/.zshrc"

    if [[ -n "${ZGEN_CUSTOM_COMPDUMP}" ]]; then
        zcompare "${ZGEN_CUSTOM_COMPDUMP}"
    else
        zcompare "${ZDOTDIR:-$HOME}/.zcompdump"
    fi

    for f in ${ZDOTDIR}/rc/*.zsh; do
        zcompare "$f"
    done

    # Compile plugin files managed by Zgen
    for f in ${ZGEN_DIR}/**/*.zsh; do
        zcompare "$f"
    done

    if [[ -d "${ZGEN_DIR}/zdharma/fast-syntax-highlighting-master" ]]; then
        for f in fast-highlight fast-read-ini-file fast-string-highlight; do
            zcompare "${ZGEN_DIR}/zdharma/fast-syntax-highlighting-master/${f}"
        done
    fi
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

    # Load local configuration file.
    for f in ${ZDOTDIR}/rc/[0-9][0-9]_*.zsh; do
        zgen load "$f"
    done

    zgen load "denysdovhan/spaceship-prompt" "spaceship"

    # generate $ZGEN_INIT file
    zgen save

    # Compile files if necessary
    zsh_compile_all
fi

source "${ZGEN_INIT}"

##=====================================================================
## Machine local settings
##=====================================================================
loadlib "${ZDOTDIR:-$HOME}/.zshrc_local"
if [[ -e "${ZDOTDIR:-$HOME}/.zshrc_secret" ]]; then
    source "${ZDOTDIR:-$HOME}/.zshrc_secret"
fi

##=====================================================================
## Profiling
##=====================================================================
#if type zprof > /dev/null 2>&1; then
#    zprof | less
#fi

if [[ "$PROFILE_STARTUP" == true ]]; then
    unsetopt xtrace
    exec 2>&3 3>&-
fi

# ----- End of zshrc -----
# vim: foldmethod=marker
