#!/bin/bash

CWD=`pwd`
DOTFILES='gitconfig latexmk tmux.conf vimrc zshenv'

if [ -z "${XDG_CONFIG_HOME}" ]
then
    XDG_CONFIG_HOME="${HOME}/.config"
fi

for f in ${DOTFILES}
do
    ln -fsv ${CWD}/${f} ${HOME}/.${f}
done

for dir in ${CWD}/config/*
do
    ln -fnsv ${dir} ${XDG_CONFIG_HOME}/${dir##*/}
done

if [ "$(uname)" == 'Darwin' ]
then
    ln -fnsv ${CWD}/hammerspoon ${HOME}/.hammerspoon
fi
