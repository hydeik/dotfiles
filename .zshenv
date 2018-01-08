# -*- mode: sh; coding: utf-8-unix; indent-tabs-mode: nil -*-
##
## File ~/.zshenv
##

##
## NOTE: Zsh configuration file loading order
##

# -- login shell
# 1. /etc/zshenv
# 2. ${ZDOTDIR}/.zshenv
# 3. /etc/zprofile
# 4. ${ZDOTDIR}/.zprofile
# 5. /etc/zshrc
# 6. ${ZDOTDIR}/.zshrc
# 7. /etc/zlogin
# 8. ${ZDOTDIR}/.zlogin

# -- interactive shell
# 1. /etc/zshenv
# 2. ${ZDOTDIR}/.zshenv
# 3. /etc/zshrc
# 4. ${ZDOTDIR}/.zshrc

# -- shell script (non-interactive)
# 1. /etc/zshenv
# 2. ${ZDOTDIR}/.zshenv

# -- logout
# 1. ${ZDOTDIR}/.zlogout
# 2. /etc/zlogout

##
## Don't load /etc/profile, /etc/zprofile
##
setopt no_global_rcs

##
## XDG Base Directory Specification
##
# --- User directories
export XDG_CONFIG_HOME=${HOME}/.config     # [default: $HOME/.config]
export XDG_CACHE_HOME=${HOME}/.cache       # [default: $HOME/.cache]
export XDG_DATA_HOME=${HOME}/.local/share  # [default: $HOME/.local/share]
# export XDG_RUNTIME_DIR                     # [default: ?]

# --- System directories
## [default: /usr/local/share:/usr/share]
#export XDG_DATA_DIRS=/usr/local/share:/usr/share
## [default: /etc/xdg]
#export XDG_CONFIG_DIRS=/etc/xdg 

##
## Set ZDOTFILE environment variable
##
export ZDOTDIR=${XDG_CONFIG_HOME}/zsh
if [ -f ${ZDOTDIR}/.zshenv ]; then
    source ${ZDOTDIR}/.zshenv
fi

