# -*- mode: sh; coding: utf-8-unix; indent-tabs-mode: nil -*-
##
## File ~/.zshenv
##

export ZDOTDIR=${HOME}/.zsh
if [ -f ${ZDOTDIR}/.zshenv ]; then
    source ${ZDOTDIR}/.zshenv
fi
