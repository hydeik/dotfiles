##======================================================================
## Function definitions
##======================================================================
##
## --- Zsh utility functions
##
# {{{
# Compile a given zsh script if modified.
function zcompare() {
    if [[ -s "${1}" && ( ! -s "${1}.zwc" || "${1}" -nt "${1}.zwc") ]]; then
        zcompile "${1}"
    fi
}

# Load file if exists. Compile the file before source it if necessary.
function loadlib() {
    local f="${1:?'too few argument: you have to specify a file to source'}"
    if [[ -s "$f" ]]; then
        zcompare "$f"
        source "$f"
    fi
}

# Compile zsh configurations and scripts
zsh_compile_all() {
    zcompare "${ZDOTDIR}/.zshenv"
    zcompare "${ZDOTDIR}/.zshrc"
    zcompare "${ZDOTDIR:-$HOME}/.zcompdump"

    for f in ${ZDOTDIR}/rc/*.zsh; do
        zcompare "$f"
    done
}

# Show options set on current Zsh session
function showoptions() {
    set -o | sed -e 's/^no\(.*\)on$/\1  off/' -e 's/^no\(.*\)off$/\1  on/'
}

# Backup files and directories
function bak() {
    for i in $@ ; do
        if [[ -e $i.bak ]] || [[ -d $i.bak ]]; then
            echo "$i.bak already exist"
        else
            command cp -ir $i $i.bak
        fi
    done
}

test-truecolor() {
    awk 'BEGIN{
    s="/\\/\\/\\/\\/\\"; s=s s s s s s s s s s s s s s s s s s s s s s s;
    for (colnum = 0; colnum<256; colnum++) {
        r = 255-(colnum*255/255);
        g = (colnum*510/255);
        b = (colnum*255/255);
        if (g>255) g = 510-g;
            printf "\033[48;2;%d;%d;%dm", r,g,b;
            printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
            printf "%s\033[0m", substr(s,colnum+1,1);
        }
        printf "\n";
    }'
}

#}}}

# ----- End of file -----
# vim: foldmethod=marker
