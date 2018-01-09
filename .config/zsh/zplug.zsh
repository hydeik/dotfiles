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
zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme

# Local plugins
zplug "${ZDOTDIR}", from:local, use:"<->_*.zsh"

