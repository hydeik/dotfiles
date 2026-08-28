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

##============================================================================
## Package Manager
##============================================================================
# Activate mise
eval "$(mise activate zsh)"

##============================================================================
## Load basic configurations
##============================================================================
source "${ZDOTDIR}/rc/10_functions.zsh"
source "${ZDOTDIR}/rc/20_autoload.zsh"
source "${ZDOTDIR}/rc/30_options.zsh"
source "${ZDOTDIR}/rc/40_zstyle.zsh"
source "${ZDOTDIR}/rc/50_variables.zsh"
source "${ZDOTDIR}/rc/50_completions.zsh"
source "${ZDOTDIR}/rc/60_alias.zsh"
source "${ZDOTDIR}/rc/70_keybindings.zsh"

##============================================================================
## Plugins
##============================================================================
export ZPLUGINDIR="${ZDATADIR}/repos"
source "${ZPLUGINDIR}/github.com/romkatv/zsh-defer/zsh-defer.plugin.zsh"

source "${ZDATADIR}/vendor/starship.zsh"
source "${ZDATADIR}/vendor/fnox.zsh"
source "${ZDATADIR}/vendor/iris.zsh"
zsh-defer source "${ZDOTDIR}/rc/plugin_config/fzf.zsh"
zsh-defer source "${ZDOTDIR}/rc/plugin_config/yazi.zsh"
zsh-defer source "${ZPLUGINDIR}/github.com/zsh-users/zsh-completions/zsh-completions.plugin.zsh"
# zsh-defer source "${ZDOTDIR}/rc/plugin_config/zsh-autocomplete.zsh"
zsh-defer source "${ZDOTDIR}/rc/plugin_config/carapace.zsh"
# zsh-defer source "${ZDATADIR}/vendor/deja.zsh"
zsh-defer source "${ZDATADIR}/vendor/atuin.zsh"
zsh-defer source "${ZDATADIR}/vendor/zoxide.zsh"
zsh-defer source "${ZDATADIR}/vendor/zsh-patina.zsh"
zsh-defer source "${ZPLUGINDIR}/github.com/greymd/tmux-xpanes/tmux-xpanes.plugin.zsh"

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
## Profiling
##===========================================================================

if [[ "$PROFILE_STARTUP" == true ]]; then
    unsetopt xtrace
    exec 2>&3 3>&-
fi

# undefine the overrided `source` function
unfunction source

# ----- End of zshrc -----
# vim: foldmethod=marker

