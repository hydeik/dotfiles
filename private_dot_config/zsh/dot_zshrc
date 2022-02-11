##
## .zshrc -- Zsh configuration file (for interactive mode)
##

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
    source ${ZDOTDIR}/scripts/tmux_auto.zsh
fi


##============================================================================
## Enable Powerlevel10k instant prompt.
##============================================================================
# Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

##============================================================================
## Load configurations
##============================================================================
source "${ZDOTDIR}/plugins.zsh"

source "${ZDOTDIR}/rc/10_functions.zsh"
source "${ZDOTDIR}/rc/20_autoload.zsh"
source "${ZDOTDIR}/rc/30_options.zsh"
source "${ZDOTDIR}/rc/40_zstyle.zsh"
source "${ZDOTDIR}/rc/50_completions.zsh"
source "${ZDOTDIR}/rc/50_variables.zsh"
source "${ZDOTDIR}/rc/60_alias.zsh"
source "${ZDOTDIR}/rc/70_keybindings.zsh"

##===========================================================================
## Machine local settings
##===========================================================================
loadlib "${ZDOTDIR:-$HOME}/.zshrc_local"
if [[ -e "${ZDOTDIR:-$HOME}/.zshrc_secret" ]]; then
    source "${ZDOTDIR:-$HOME}/.zshrc_secret"
fi

##===========================================================================
## Profiling
##===========================================================================
#if type zprof > /dev/null 2>&1; then
#    zprof | less
#fi

if [[ "$PROFILE_STARTUP" == true ]]; then
    unsetopt xtrace
    exec 2>&3 3>&-
fi

# ----- End of zshrc -----
# vim: foldmethod=marker

# # To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
# [[ -f ~/.config/zsh/.p10k.zsh ]] && source ~/.config/zsh/.p10k.zsh
