export ZCOMPDUMP_FILE="${ZCACHEDIR}/zcompdump"

##
## Pass arguments to `compinit`
##
if [[ -n ${ZCOMPDUMP_FILE}(#qN.mh+24) ]]; then
    zstyle '*:compinit' arguments -d "${ZCOMPDUMP_FILE}"
else
    zstyle '*:compinit' arguments -i -u -C -w -d "${ZCOMPDUMP_FILE}"
fi

##
## First insert the common substring
##
# all Tab widgets
zstyle ':autocomplete:*complete*:*' insert-unambiguous yes

# all history widgets
zstyle ':autocomplete:*history*:*' insert-unambiguous yes

# ^S
zstyle ':autocomplete:menu-search:*' insert-unambiguous yes

##
## Change the max number of lines shown
##
# Note: -e lets you specify a dynamically generated value.

# Override default for all listings
# $LINES is the number of lines that fit on screen.
zstyle -e ':autocomplete:*:*' list-lines 'reply=( $(( LINES / 3 )) )'

# Override for recent path search only
zstyle ':autocomplete:recent-paths:*' list-lines 10

# Override for history search only
zstyle ':autocomplete:history-search:*' list-lines 16
zstyle ':autocomplete:history-incremental-search-*:*' list-lines 16

# Override for history menu only
zstyle ':autocomplete:history-search-backward:*' list-lines 2000


##
## Load the plugin
##
source "${ZPLUGINDIR}/github.com/marlonrichert/zsh-autocomplete/zsh-autocomplete.plugin.zsh"


