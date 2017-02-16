zplug "zplug/zplug", hook-build:'zplug --self-manage'

# Local plugins
zplug "~/.zsh", from:local, use:"<->_*.zsh"

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "glidenote/hub-zsh-completion"

#zplug "dracula/zsh", as:theme
#zplug "jeremyFreeAgent/oh-my-zsh-powerline-theme", as:theme

zplug "b4b4r07/enhancd", use:init.sh
zplug "b4b4r07/zsh-gomi", if:"which fzf"

zplug "mollifier/anyframe", lazy:true

# Install commands' binary if necessart
# zplug "stedolan/jq", \
#     as:command, \
#     from:gh-r, \
#     rename-to:jq
# 
# zplug "junegunn/fzf-bin", \
#     as:command, \
#     from:gh-r, \
#     rename-to:"fzf", \
#     frozen:1
# 
# zplug "monochromegane/the_platinum_searcher", \
#     as:command, \
#     from:gh-r, \
#     rename-to:"pt", \
#     frozen:1
# 
# zplug "peco/peco", \
#     as:command, \
#     from:gh-r, \
#     frozen:1
# 
# zplug "motemen/ghq", \
#     as:command, \
#     from:gh-r, \
#     rename-to:ghq
# 
# zplug "jhawthorn/fzy", \
#     as:command, \
#     hook-build:"make && sudo make install"

