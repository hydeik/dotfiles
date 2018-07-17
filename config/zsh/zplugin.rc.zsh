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

# Powerlevel9k -- themes using Powerline fonts
POWERLEVEL9K_MODE="nerdfont-complete"

# POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR="\ue0b0"
# -- Insert additional space after the separator char (for Cica font)
# POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR="\ue0b2 "

# Prompt
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true

POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="\n"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="\uf0da "

#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(icons_test)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon context dir_writable dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs pyenv virtualenv load ram disk_usage)

POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
POWERLEVEL9K_TIME_FORMAT="%D{\uf017 %H:%M:%S \uf073 %y-%m-%d}"
POWERLEVEL9K_STATUS_VERBOSE=false

PS1="READY > "
zplugin ice wait'!0'
zplugin light "bhilburn/powerlevel9k"

# zsh-completions
zplugin ice wait'0' blockf
zplugin light "zsh-users/zsh-completions"

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
