##
## .zshrc -- Zsh configuration file (for interactive mode)
##

# source command override technique
function ensure_zcompiled {
    local compiled="$1.zwc"
    if [[ ! -r "$compiled" || "$1" -nt "$compiled" ]]; then
        echo "\033[1;36mCompiling\033[m $1"
        zcompile $1
    fi
}

function source {
    ensure_zcompiled $1
    builtin source $1
}


# ensure .zshrc and .zshenv are zcompiled
ensure_zcompiled "${ZDOTDIR}/.zshenv"
ensure_zcompiled "${ZDOTDIR}/.zshrc"

# # Return if zsh is called from Vim
# if [[ -n $VIMRUNTIME ]]; then
#     return 0
# fi

# Setup Fzf
if [[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ]]; then
    source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh
fi

## Tmux
# Attach tmux session automatically if exists, create new session otherwise.
if (( ${+commands[tmux]} )); then
    export TMUX_AUTO_START=true
    export PERCOL=fzf
    export ZENO_ENABLE_FZF_TMUX=1
    source ${ZDOTDIR}/scripts/tmux_auto.zsh
fi

# ##============================================================================
# ## Enable Powerlevel10k instant prompt.
# ##============================================================================
# # Should stay close to the top of ~/.zshrc.
# # Initialization code that may require console input (password prompts, [y/n]
# # confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#     source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

##============================================================================
##  Sheldon plugin manager
##============================================================================
# sheldon cache technique
export SHELDON_CONFIG_DIR="${ZDOTDIR}/sheldon"
sheldon_cache="${SHELDON_CONFIG_DIR}/sheldon.zsh"
sheldon_toml="${SHELDON_CONFIG_DIR}/plugins.toml"
if  [[ ! -r "$sheldon_cache" || "$sheldon_toml" -nt "$sheldon_cache" ]]; then
    sheldon source > $sheldon_cache
fi
source "$sheldon_cache"
unset sheldon_cache sheldon_toml

##============================================================================
## Load configurations
##============================================================================

source "${ZDOTDIR}/rc/10_functions.zsh"
source "${ZDOTDIR}/rc/20_autoload.zsh"
source "${ZDOTDIR}/rc/30_options.zsh"
source "${ZDOTDIR}/rc/40_zstyle.zsh"
source "${ZDOTDIR}/rc/50_variables.zsh"

zsh-defer source "${ZDOTDIR}/rc/50_completions.zsh"
zsh-defer source "${ZDOTDIR}/rc/60_alias.zsh"
zsh-defer source "${ZDOTDIR}/rc/70_keybindings.zsh"

##===========================================================================
## Machine local settings
##===========================================================================
if [[ -r "${ZDOTDIR:-$HOME}/.zshrc_local" ]]; then
    source "${ZDOTDIR:-$HOME}/.zshrc_local"
fi
if [[ -r "${ZDOTDIR:-$HOME}/.zshrc_secret" ]]; then
    source "${ZDOTDIR:-$HOME}/.zshrc_secret"
fi

##===========================================================================
## Prompt
##===========================================================================
zsh-defer source "${ZDOTDIR}/p10k.zsh"

##===========================================================================
## Profiling
##===========================================================================

if [[ "$PROFILE_STARTUP" == true ]]; then
    unsetopt xtrace
    exec 2>&3 3>&-
fi

## undefine the overrided `source` function
unfunction source

# ----- End of zshrc -----
# vim: foldmethod=marker
