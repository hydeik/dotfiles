zplug "zplug/zplug", hook-build:'zplug --self-manage'

zplug "zsh-users/zsh-completions", lazy:true
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "plugins/cargo", lazy:true, from:oh-my-zsh
zplug "plugins/pip", lazy:true, from:oh-my-zsh
zplug "plugins/rust", lazy:true, from:oh-my-zsh

zplug "esc/conda-zsh-completion", lazy:true
zplug "mollifier/anyframe", lazy:true

export AUTOENV_ENABLE_LEAVE=true
zplug "kennethreitz/autoenv", use:"activate.sh", defer:2, from:github


case ${OSTYPE} in
    linux*)
        # Install commands' binary if necessart
        zplug "stedolan/jq", \
            as:command, \
            from:gh-r, \
            rename-to:jq

        zplug "junegunn/fzf-bin", \
            as:command, \
            from:gh-r, \
            rename-to:"fzf", \
            frozen:1

        zplug "monochromegane/the_platinum_searcher", \
            as:command, \
            from:gh-r, \
            rename-to:"pt", \
            frozen:1

        zplug "peco/peco", \
            as:command, \
            from:gh-r, \
            frozen:1

        zplug "motemen/ghq", \
            as:command, \
            from:gh-r, \
            rename-to:ghq

        zplug "jhawthorn/fzy", \
            as:command, \
            hook-build:"make && sudo make install"
        ;;
    *)
        ;;
esac

# Theme
#zplug mafredri/zsh-async, from:github
#zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme, from:github, as:theme

POWERLEVEL9K_MODE="nerdfont-complete"

# POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR="\ue0b0"
# -- Insert additional space after the separator char (for Cica font)
# POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR="\ue0b2 "

# Prompt
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=false

POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="\uf0da "

#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(icons_test)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon context dir_writable dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs pyenv virtualenv load disk_usage ram)

POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
POWERLEVEL9K_TIME_FORMAT="%D{\uf017 %H:%M:%S \uf073 %y-%m-%d}"
POWERLEVEL9K_STATUS_VERBOSE=false

# Local plugins
zplug "${ZDOTDIR}", from:local, use:"<->_*.zsh"


