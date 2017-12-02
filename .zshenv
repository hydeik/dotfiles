# -*- mode: sh; coding: utf-8-unix; indent-tabs-mode: nil -*-
##
## File ~/.zshenv
##

##
## Set ZDOTFILE environment variable
##
export ZDOTDIR=${HOME}/.zsh
if [ -f ${ZDOTDIR}/.zshenv ]; then
    source ${ZDOTDIR}/.zshenv
fi

##
## Zsh custom file loading order
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
## Do not read /etc/profile, /etc/zprofile
##
setopt no_global_rcs

