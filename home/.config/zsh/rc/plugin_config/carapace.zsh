# Generate shell integration using the following command:
# `carapace _carapace zsh | grep -v '^compdef '`
source "${ZDATADIR}/vendor/carapace.zsh"

# Use zsh built-in completer first, then fallback to carapace
zstyle ':completion:*' completer _complete _carapace_completer _ignored
