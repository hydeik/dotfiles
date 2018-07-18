#!/bin/bash

CWD=$(pwd)
DOTFILES='editorconfig gitconfig latexmkrc zshenv'

if [ -z "${XDG_CONFIG_HOME}" ]
then
    XDG_CONFIG_HOME="${HOME}/.config"
fi

for f in ${DOTFILES}
do
    ln -fsv "${CWD}/${f}" "${HOME}/.${f}"
done

for dir in ${CWD}/config/{fish,zsh,alacritty}
do
    ln -fnsv "${dir}" "${XDG_CONFIG_HOME}/${dir##*/}"
done

# Make symlink for VIM configuration
ln -fnsv "${CWD}/vim" "${HOME}/.vim"

# Make symlink for NeoVim configuration
ln -fnsv "${CWD}/vim" "${XDG_CONFIG_HOME}/nvim"

# Make symling for Tmux configuration
ln -fnsv "${CWD}/tmux" "${HOME}/.tmux"
ln -fsv  "${CWD}/tmux.conf" "${HOME}/.tmux.conf"

if [ "$(uname)" == 'Darwin' ]
then
    ln -fnsv "${CWD}/hammerspoon" "${HOME}/.hammerspoon"

    for f in ${CWD}/config/karabiner/assets/complex_modifications/*.json
    do
        ln -fsv "$f" "${XDG_CONFIG_HOME}/karabiner/assets/complex_modifications/"
    done
fi
