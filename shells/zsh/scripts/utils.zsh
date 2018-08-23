# compile zsh scripts if modified.
zcompare() {
    if [[ -s "${1}" && ( ! -s "${1}.zwc" || "${1}" -nt "${1}.zwc") ]]; then
        zcompile "${1}"
    fi
}

# compile all the files provided as arguments
zcompile_all() {
    for f in "$*"; do
        zcompare "$f"
    done
}

# load file if exists
loadlib() {
    local f="${1:?'too few argument: you have to specify a file to source'}"
    if [[ -s "$f" ]]; then
        zcompare "$f"
        source "$f"
    fi
}

# Compile zsh configurations and scripts
zsh_compile_all() {
    setopt extended_glob
    local zsh_glob='^(.git*|LICENSE|README.md|*.zwc)(.)'
    zcompare "${ZDOTDIR}/.zshenv"
    zcompare "${ZDOTDIR}/.zshrc"
    for conf in ${ZDOTDIR}/rc/<->_*.zsh; do
        zcompare "${conf}"
    done

    if [[ -n "${ZGEN_CUSTOM_COMPDUMP}" ]]; then
        zcompare "${ZGEN_CUSTOM_COMPDUMP}"
    else
        zcompare "${ZDOTDIR:-$HOME}/.zcompdump"
    fi

    # Compile plugin files managed by Zgen
    for f in ${ZGEN_DIR}/**/*.zsh; do
        zcompare "$f"
    done

    if [[ -d "${ZGEN_DIR}/zdharma/fast-syntax-highlighting-master" ]]; then
        for f in fast-highlight fast-read-ini-file fast-string-highlight; do
            zcompare "${ZGEN_DIR}/zdharma/fast-syntax-highlighting-master/${f}"
        done
    fi

    if [[ -d "${ZGEN_DIR}/mollifier/anyframe-master" ]]; then
        zcompare "${ZGEN_DIR}/mollifier/anyframe-master/anyframe-init"
        for f in ${ZGEN_DIR}/mollifier/anyframe-master/**/^(README.md|*.zwc)(.); do
            zcompare "$f"
        done
    fi
}
