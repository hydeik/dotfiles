zplugin snippet "${ZDOTDIR}/10_utils.zsh"
zplugin snippet "${ZDOTDIR}/20_modules.zsh"
zplugin snippet "${ZDOTDIR}/30_aliases.zsh"

# Zsh port of the fish history search
zplugin light "zsh-users/zsh-history-substring-search"

# shell completion for rustc
zplugin ice blockf
zplugin light "rust-lang/zsh-config"

# Directory listing for zsh with git features
zplugin ice pick"k.sh"
zplugin light "supercrabtree/k"

# peco/percol/fzf wrapper plugin for zsh
zplugin light "mollifier/anyframe"

# Emoji on the command line
zplugin ice as"command" pick"emojify"
zplugin light "mrowa44/emojify"

# Emoji completion on the command line (depends jq, and an interactive filter
# such as fzf, peco, etc.)
zplugin light "b4b4r07/emoji-cli"

case ${OSTYPE} in
    linux*)
        zplugin ice from"gh-r" as"program" mv"fzf-* -> fzf"
        zplugin load "junegunn/fzf-bin"

        zplugin ice from"gh-r" as"program" mv"jq-* -> jq" bpick"*linux*"
        zplugin load "stedolan/jq"

        zplugin ice from"gh-r" as"program" bpick"*linux*"
        zplugin load "peco/peco"

        zplugin ice from"gh-r" as"program"
        zplugin load "motemen/ghq"
        ;;
    *)
        ;;
esac

# zsh-completions
zplugin ice wait'0' blockf
zplugin light "zsh-users/zsh-completions"

# A next-generation `cd` command with an interactive filter
export ENHANCD_DIR=${XDG_CACHE_HOME}/enhancd
export ENHANCD_DISABLE_DOT=0
export ENHANCD_DISABLE_HYPHEN=0
export ENHANCD_DISABLE_HOME=0

zplugin ice wait'0' pick'init.sh'
zplugin light "b4b4r07/enhancd"

# Fish-like autosuggestions for zsh
zplugin ice wait'1' atload"_zsh_autosuggest_start"
zplugin light "zsh-users/zsh-autosuggestions"

# Optimized and extended zsh-syntax-highlighting
zplugin ice wait'0' atinit"zpcompinit; zpcdreplay"
zplugin light zdharma/fast-syntax-highlighting

# Ultimate terminal divider powered by tmux
zplugin ice wait'[[ -n ${ZLAST_COMMANDS[(r)xpan*]} ]]'
zplugin light "greymd/tmux-xpanes"

# Other local plugins
zplugin snippet "${ZDOTDIR}/40_keybinds.zsh"
zplugin snippet "${ZDOTDIR}/50_options.zsh"
zplugin snippet "${ZDOTDIR}/60_completion.zsh"
zplugin snippet "${ZDOTDIR}/70_misc.zsh"
