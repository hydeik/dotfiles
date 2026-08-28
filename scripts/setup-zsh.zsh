#!/usr/bin/env zsh

set -euo pipefail

ZSH_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zsh"
mkdir -p "${ZSH_DATA_DIR}/completions"
mkdir -p "${ZSH_DATA_DIR}/vendor"

# -- mise
if (( ${+commands[mise]} )); then
    # mise activate zsh > "${ZSH_DATA_DIR}/vendor/mise.zsh"
    # zcompile "${ZSH_DATA_DIR}/vendor/mise.zsh"
    mise completion zsh > "${ZSH_DATA_DIR}/completions/_mise"
fi

# -- atuin
if (( ${+commands[atuin]} )); then
    export ATUIN_NOBIND="true"
    atuin init zsh > "${ZSH_DATA_DIR}/vendor/atuin.zsh"
    zcompile "${ZSH_DATA_DIR}/vendor/atuin.zsh"
fi

# -- carapace
if (( ${+commands[carapace]} )); then
    carapace _carapace zsh | grep -v '^compdef ' > "${ZSH_DATA_DIR}/vendor/carapace.zsh"
    zcompile "${ZSH_DATA_DIR}/vendor/carapace.zsh"
fi

# -- deja
if (( ${+commands[deja]} )); then
    deja init zsh > "${ZSH_DATA_DIR}/vendor/deja.zsh"
    zcompile "${ZSH_DATA_DIR}/vendor/deja.zsh"
fi

# -- fnox
if (( ${+commands[fnox]} )); then
    fnox activate zsh > "${ZSH_DATA_DIR}/vendor/fnox.zsh"
    fnox completions zsh > "${ZSH_DATA_DIR}/completions/_fnox"
    zcompile "${ZSH_DATA_DIR}/vendor/fnox.zsh"
fi

# -- fzf
if (( ${+commands[fzf]} )); then
    fzf --zsh > "${ZSH_DATA_DIR}/vendor/fzf.zsh"
    zcompile "${ZSH_DATA_DIR}/vendor/fzf.zsh"
fi

# -- iris
if (( ${+commands[iris]} )); then
    iris init zsh > "${ZSH_DATA_DIR}/vendor/iris.zsh"
    zcompile "${ZSH_DATA_DIR}/vendor/iris.zsh"
fi

# -- starship
if (( ${+commands[starship]} )); then
    starship init zsh > "${ZSH_DATA_DIR}/vendor/starship.zsh"
    zcompile "${ZSH_DATA_DIR}/vendor/starship.zsh"
fi

# -- zoxide
if (( ${+commands[zoxide]} )); then
    zoxide init zsh > "${ZSH_DATA_DIR}/vendor/zoxide.zsh"
    zcompile "${ZSH_DATA_DIR}/vendor/zoxide.zsh"
fi

# -- zsh-patina
if (( ${+commands[zsh-patina]} )); then
    zsh-patina activate > "${ZSH_DATA_DIR}/vendor/zsh-patina.zsh"
    zsh-patina completion > "${ZSH_DATA_DIR}/completions/_zsh-patina"
    zcompile "${ZSH_DATA_DIR}/vendor/zsh-patina.zsh"
fi

