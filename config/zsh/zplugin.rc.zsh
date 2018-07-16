zplugin snippet "${ZDOTDIR}/10_utils.zsh"
zplugin snippet "${ZDOTDIR}/20_modules.zsh"
zplugin snippet "${ZDOTDIR}/30_aliases.zsh"

# Optimized and extended zsh-syntax-highlighting
zplugin ice wait"0" atinit"zpcompinit" lucid
zplugin light zdharma/fast-syntax-highlighting

# Fish-like autosuggestions for zsh
zplugin ice wait"1" atload"_zsh_autosuggest_start"
zplugin light "zsh-users/zsh-autosuggestions"

# zsh-completions
zplugin ice blockf
zplugin light "zsh-users/zsh-completions"

zplugin snippet "https://github.com/rust-lang/cargo/blob/master/src/etc/_cargo"
zplugin light "rust-lang/zsh-config"

# peco/percol/fzf wrapper plugin for zsh
zplugin light "mollifier/anyframe"

# Directory listing for zsh with git features
zplugin ice pick"k.sh"
zplugin light "supercrabtree/k"

# Emoji completion on the command line (depends jq, and an interactive filter
# such as fzf, peco, etc.)
zplugin light "b4b4r07/emoji-cli"

# Ultimate terminal divider powered by tmux
zplugin light "greymd/tmux-xpanes"

case ${OSTYPE} in
    linux*)
        zplugin ice from"gh-r" as"program" mv"fzf-* -> fzf"
        zplugin load "junegunn/fzf-bin"

        zplugin ice from"gh-r" as"program"
        zplugin load "stedolan/jq"

        zplugin ice from"gh-r" as"program"
        zplugin load "peco/peco"

        zplugin ice from"gh-r" as"program"
        zplugin load "motemen/ghq"
        ;;
    *)
        ;;
esac

# Powerlevel9k -- themes using Powerline fonts
PS1="READY > "
zplugin ice wait"!1" lucid
zplugin light "bhilburn/powerlevel9k"

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

# Other local plugins
zplugin snippet "${ZDOTDIR}/40_keybinds.zsh"
zplugin snippet "${ZDOTDIR}/50_options.zsh"
zplugin snippet "${ZDOTDIR}/60_completion.zsh"
zplugin snippet "${ZDOTDIR}/70_misc.zsh"
