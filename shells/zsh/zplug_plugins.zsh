zplug "zplug/zplug", hook-build:"zplug --self-manage"

case ${OSTYPE} in
    linux*)
        zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf
        zplug "junegunn/fzf", as:command, use:"bin/fzf-tmux"

        zplug "stedolan/jq", from:gh-r, as:command, rename-to:jq

        zplug "motemen/ghq", from:gh-r, as:command
        ;;
    *)
        ;;
esac

# A next-generation `cd` command with an interactive filter
export ENHANCD_DIR="${XDG_CACHE_HOME}/enhancd"
export ENHANCD_DISABLE_DOT=0
export ENHANCD_DISABLE_HYPHEN=0
export ENHANCD_DISABLE_HOME=0
zplug "b4b4r07/enhancd", use:"init.sh"

# Ultimate terminal divider powered by tmux
zplug "greymd/tmux-xpanes"

# peco/percol/fzf wrapper plugin for Zsh
zplug "mollifier/anyframe", lazy:1

# Additional completions for Zsh
zplug "zsh-users/zsh-completions"

# Zsh completions for **env
zplug "39e/zsh-completions-anyenv"

# Fish-like autosuggestions for zsh
zplug "zsh-users/zsh-autosuggestions"

# Optimized and extended zsh-syntax-highlighting
zplug "zdharma/fast-syntax-highlighting", defer:2

# Zsh port of the fish history search
zplug "zsh-users/zsh-history-substring-search", defer:3

