##
## .zshrc -- Zsh configuration file (for interactive mode)
##

# # Return if zsh is called from Vim
# if [[ -n $VIMRUNTIME ]]; then
#     return 0
# fi

## Tmux
# Attach tmux session automatically if exists, create new session otherwise.
if (( ${+commands[tmux]} )); then
    export TMUX_AUTO_START=true
    export PERCOL=fzf
    source ${ZDOTDIR}/scripts/tmux_auto.zsh
fi

##======================================================================
## Function definitions
##======================================================================
##
## --- Zsh utility functions
##
#{{{
# compile zsh scripts if modified.
zcompare() {
    if [[ -s "${1}" && ( ! -s "${1}.zwc" || "${1}" -nt "${1}.zwc") ]]; then
        zcompile "${1}"
    fi
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

    # if [[ -d "${ZGEN_DIR}/mollifier/anyframe-master" ]]; then
    #     zcompare "${ZGEN_DIR}/mollifier/anyframe-master/anyframe-init"
    #     for f in ${ZGEN_DIR}/mollifier/anyframe-master/**/^(README.md|*.zwc)(.); do
    #         zcompare "$f"
    #     done
    # fi
}

# Show options set on current Zsh session
showoptions() {
    set -o | sed -e 's/^no\(.*\)on$/\1  off/' -e 's/^no\(.*\)off$/\1  on/'
}

#}}}

##
## --- Anyenv, pyenv, etc., extracted from $(anyenv init -)
##
#{{{

# anyenv
anyenv() {
    typeset command
    command="$1"
    if [ "$#" -gt 0 ]; then
        shift
    fi
    command anyenv "$command" "$@"
}

# goenv
goenv() {
    local command
    command="$1"
    if [ "$#" -gt 0 ]; then
        shift
    fi

    case "$command" in
        rehash|shell)
            eval "$(goenv "sh-$command" "$@")";;
        *)
            command goenv "$command" "$@";;
    esac
}

# # ndenv
# ndenv() {
#     typeset command
#     command="$1"
#     if [ "$#" -gt 0 ]; then
#         shift
#     fi
#
#     case "$command" in
#         rehash|shell|update)
#             eval "`ndenv "sh-$command" "$@"`";;
#         *)
#             command ndenv "$command" "$@";;
#     esac
# }

# nodenv
nodenv() {
    local command
    command="$1"
    if [ "$#" -gt 0 ]; then
        shift
    fi

    case "$command" in
        rehash|shell)
            eval "$(nodenv "sh-$command" "$@")";;
        *)
            command nodenv "$command" "$@";;
    esac
}

# pyenv
pyenv() {
    local command
    command="${1:-}"
    if [ "$#" -gt 0 ]; then
        shift
    fi

    case "$command" in
        activate|deactivate|rehash|shell)
            eval "$(pyenv "sh-$command" "$@")";;
        *)
            command pyenv "$command" "$@";;
    esac
}

# rbenv
rbenv() {
    local command
    command="${1:-}"
    if [ "$#" -gt 0 ]; then
        shift
    fi

    case "$command" in
        rehash|shell|update)
            eval "$(rbenv "sh-$command" "$@")";;
        *)
            command rbenv "$command" "$@";;
    esac
}

#}}}

##======================================================================
## Plugins
##======================================================================
##
## Zgen plugin manager
##
#{{{
export ZGEN_DIR="${ZDOTDIR}/.zgen"
export ZGEN_INIT="${ZGEN_DIR}/init.zsh"
#export ZGEN_CUSTOM_COMPDUMP="${XDG_CACHE_HOME}/zsh/zcompdump"
# compinit is called manually.
export ZGEN_AUTOLOAD_COMPINIT=0

# Load zgen only if a user types a zgen command
zgen () {
    unset -f zgen
    if [[ ! -s "${ZGEN_DIR}/zgen.zsh" ]]; then
        git clone --recursive https://github.com/tarjoilija/zgen.git "${ZGEN_DIR}"
    fi
    source "${ZGEN_DIR}/zgen.zsh"
    zgen "$@"
}

# Generate zgen init script (cache) if needed
if [[ ! -s "${ZGEN_DIR}/init.zsh" ]]; then
    # plugins
    zgen load "greymd/tmux-xpanes"
    # zgen load "mollifier/anyframe"
    zgen load "junegunn/fzf"  "shell/key-bindings.zsh"
    zgen load "junegunn/fzf"  "shell/completion.zsh"
    zgen load "zsh-users/zsh-completions"
    zgen load "zsh-users/zsh-autosuggestions"
    zgen load "zdharma/fast-syntax-highlighting"
    zgen load "zsh-users/zsh-history-substring-search"

    # generate $ZGEN_INIT file
    zgen save

    # Compile files if necessary
    zsh_compile_all
fi

source "${ZGEN_INIT}"
#}}}

##======================================================================
## Autoload modules
##======================================================================
# {{{

autoload -Uz compinit
autoload -Uz colors
autoload -Uz cdr
autoload -Uz chpwd_recent_dirs
autoload -Uz add-zsh-hook
autoload -Uz modify-current-argument
autoload -Uz select-word-style
autoload -Uz smart-insert-last-word
autoload -Uz terminfo
autoload -Uz vcs_info
autoload -Uz zcalc
autoload -Uz zmv
autoload -Uz run-help-git
autoload -Uz run-help-svk
autoload -Uz run-help-svn

# }}}

##======================================================================
## Options  [man zshoptions]
##======================================================================

## --- Changing directories
# {{{

# If a command is issued that can’t be executed as a normal command, and the
# command is the name of a directory, perform the cd command to that directory.
setopt auto_cd

# Make cd push the old directory onto the directory stack.
# (NOTE: Type `cd -[TAB]` to show the directory stack.)
setopt auto_pushd

# Don’t push multiple copies of the same directory onto the directory stack.
setopt pushd_ignore_dups

# Have `pushd` with no arguments act like `pushd $HOME`.
setopt pushd_to_home

# Do not print the directory stack after `pushed` or `popd`
#setopt pushd_silent

# }}}

## --- Completion
# {{{

# Move cursor to the end of a completed word.
setopt always_to_end

# Show completion menu on a successive tab press.
setopt auto_menu

# Automatically list choices on ambiguous completion.
setopt auto_list

# If completed parameter is a directory, add a trailing slash.
setopt auto_param_slash

# If completed parameter is a directory and input a word delimiter, remove the
# last slash.
setopt auto_remove_slash

# Complete from both ends of a word.
setopt complete_in_word

# Try to make the completion list smaller.
setopt list_packed

# When listing files that are possible completions, show the type of each file
# with a trailing identifying mark.
setopt list_types

# Do not autoselect the first completion entry.
unsetopt menu_complete

# }}}

## --- Expansion and Globbing
# {{{

# Make globbing insensitive to case.
unsetopt case_glob

# Perform =filename expansion
setopt equals

# Treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename
# generation, etc.
setopt extended_glob

# Enable completion after = in command line arguments, e.g., "--prefix=~/dir".
# The main purpose of this option is complete after tilde.
setopt magic_equal_subst

# If numeric filenames are matched by a filename generation pattern, sort the
# filenames numerically rather than lexicographically.
setopt numeric_glob_sort

# }}}

## --- History
# {{{

# Save each command’s beginning timestamp (in seconds since the epoch) and the
# duration (in seconds) to the history file.
setopt extended_history

# When searching for history entries in the line editor, do not display
# duplicates of a line previously found, (even if the duplicates are not
# contiguous).
setopt hist_find_no_dups

# If a new command line being added to the history list duplicates an older
# one, the older command is removed from the list (even if it is not the
# previous event).
setopt hist_ignore_all_dups

# Do not enter command lines into the history list if they are duplicates of
# the previous event.
setopt hist_ignore_dups

# Remove command lines from the history list when the first character on the
# line is a space, or when one of the expanded aliases contains a leading
# space.
setopt hist_ignore_space

# Remove the function definitions from the history list.
setopt hist_no_functions

# Remove the `history` (`fc -l`) command from the history list when invoked.
setopt hist_no_store

# Remove superfluous blanks from each command line being added to the history
# list.
setopt hist_reduce_blanks

# When writing out the history file, older commands that duplicate newer ones are omitted.
setopt hist_save_no_dups

# Share history
setopt share_history

# }}}

## --- Input/Output
# {{{

# Try to correct the spelling of commands
setopt correct

# Disable output flow control via start/stop characters in the shell's editor
# (usually assigned to ^S/^Q).
unsetopt flow_control

# Do not exit on end-of-file (^D)
#setopt ignore_eof

# Allow comments even in interactive shells
setopt interactive_comments

# Perform path search even on command names with slashes.
setopt path_dirs

# Print eight bit characters literally in completion lists, etc.
setopt print_eight_bit

# Do not query the user before executing ‘rm *’ or ‘rm path/*’.
#setopt rm_star_silent

# If querying the user before executing ‘rm *’ or ‘rm path/*’, first wait ten
# seconds and ignore anything typed in that time.
setopt rm_star_wait

# }}}

## --- Job Control
# {{{

# If set, report the status of background and suspended jobs before exiting a
# shell with job control; a second attempt to exit the shell will succeed.
# NO_CHECK_JOBS is best used only in combination with NO_HUP, else such jobs
# will be killed automatically.
unsetopt check_jobs
# Don't send the HUP signal to running (background) jobs when the shell exits.
unsetopt hup

# }}}

## --- Zle
# {{{

# Do not beep on error in Zle
unsetopt beep

# }}}

##=====================================================================
## Completions
##=====================================================================
# {{{

# Speed up zsh compinit by only checking cache once a day.
# This piece of code is taken from
# https://gist.github.com/ctechols/ca1035271ad13484128
if [[ -n ${ZDOTDIR:-${HOME}}/.zcompdump(#qN.mh+24) ]]; then
    compinit;
else
    compinit -C;
fi;

# Use caching to make completion for commands such as dpkg and apt usable.
zstyle ':completion::complete:*' use-cache true
# Location of cache directory [default: ${ZDOTDIR:-$HOME}/.zcompcache]
# zstyle ':completion::complete:*' cache-path "${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/zcompchache"

# Case-insensitive (all), partial-word, and then substring completion.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Colorlize completion results
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# Enable to select completion targets by cursor move
zstyle ':completion:*:default' menu select=2

# Group matches and describe.
zstyle ':completion:*:matches' group yes
zstyle ':completion:*:options' description yes
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes

# Fuzzy match mistyped completions.
zstyle ':completion:*' completer _oldlist _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Increase the number of errors based on the length of the typed word.
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'

# Don't complete unavailable commands.
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

# Array completion element sorting.
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Directories
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true

# History
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# Environmental Variables
zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

# Populate hostname completion.
zstyle -e ':completion:*:hosts' hosts 'reply=(
  ${=${=${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) 2>/dev/null)"}%%[#| ]*}//\]:[0-9]*/ }//,/ }//\[/ }
  ${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2>/dev/null))"}%%\#*}
  ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2>/dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
)'

# Don't complete uninteresting users...
zstyle ':completion:*:*:*:users' ignored-patterns \
  adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
  dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
  hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
  mailman mailnull mldonkey mysql nagios \
  named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
  operator pcap postfix postgres privoxy pulse pvm quagga radvd \
  rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs '_*'

# ... unless we really want to.
zstyle '*' single-ignored show

# Ignore multiple entries.
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:rm:*' file-patterns '*:all-files'

# Kill
zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single

# Man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

# SSH/SCP/RSYNC
zstyle ':completion:*:(scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

# }}}

##=====================================================================
## Customize
##=====================================================================

## --- Colors for ls
# {{{
# for GNU ls
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# for BSD, OSX (builtin)
export LSCOLORS=exfxcxdxbxegedabagacad
# }}}

## --- less
# {{{

# Less status line
export LESS='-R -f -X -i -P ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'
export LESSCHARSET='utf-8'
# Less history file
export LESSHISTFILE="${XDG_CACHE_HOME}/less/history"

# LESS man page colors (makes Man pages more readable).
# Source: http://unix.stackexchange.com/a/147
# More info: http://unix.stackexchange.com/a/108840
less() {
    export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
    export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan
    export LESS_TERMCAP_me=$(tput sgr0)
    export LESS_TERMCAP_so=$(tput bold; tput setaf 0; tput setab 4) # black on blue
    export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
    export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
    export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
    export LESS_TERMCAP_mr=$(tput rev)
    export LESS_TERMCAP_mh=$(tput dim)
    export LESS_TERMCAP_ZN=$(tput ssubm)
    export LESS_TERMCAP_ZV=$(tput rsubm)
    export LESS_TERMCAP_ZO=$(tput ssupm)
    export LESS_TERMCAP_ZW=$(tput rsupm)
    unset -f less
    less "$@"
}

# }}}

## --- History
# {{{

# History file
HISTFILE="${ZDOTDIR}/zsh_history"
# History size in memory
HISTSIZE=100000
# The number of histsize
SAVEHIST=100000
# The size of asking history
LISTMAX=100
# Do not record command line history in root
if [[ "$UID" == 0 ]]; then
    unset HISTFILE
    SAVEHIST=0
fi

# }}}

## --- cdr
# {{{

add-zsh-hook chpwd chpwd_recent_dirs
zstyle ":chpwd:*" recent-dirs-max 1000
zstyle ":chpwd:*" recent-dirs-default true
zstyle ":chpwd:*" recent-dirs-file "${ZDOTDIR}/chpwd-recent-dirs"

#  }}}

## --- word-stype
# {{{

select-word-style default
# Set the list of characters regarded as delemeters
zstyle ':zle:*' word-chars " _-/;@:{}[]()<>,|."
zstyle ':zle:*' word-style unspecified
# }}}

## --- junegunn/fzf
# {{{

if (( ${+commands[fzf]} )); then
    # Default options passed to `fzf`
    export FZF_DEFAULT_OPTS='--height=50% --border'

    # Trigger sequence for fuzzy completion [default: '**']
    export FZF_COMPLETION_TRIGGER=','

    # Use fd instead of the default find command for listing path candidates.
    if (( ${+commands[fd]} )); then
        export FZF_DEFAULT_COMMAND='fd --type f'
        export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
        export FZF_CTRL_T_OPT="--multi --preview 'head -$LINES {}'"
        export FZF_ALT_C_COMMAND='fd --type d'

        # Path completion
        _fzf_compgen_path() {
            fd --hidden --follow --exclude ".git" . "$1"
        }

        # Directory completion
        _fzf_compgen_dir() {
            fd --type d --hidden --follow --exclude ".git" . "$1"
        }
    fi

    if [[ -n "$TMUX" ]]; then
        FZF_TMUX=1
        FZF_TMUX_HEIGHT='25%'
    fi

fi

# }}}

##=====================================================================
## Aliases
##=====================================================================
# {{{

## cd
alias ..='cd  ..'
alias ...='cd  ../..'
alias ....='cd  ../../..'
alias .....='cd  ../../../..'
alias ......='cd  ../../../../..'
alias .......='cd  ../../../../..'

## ls
case ${OSTYPE} in
    # colored ls
    freebsd*|darwin*)
        if (( ${+commands[gls]} )); then
            # GNU coreutils installed
            alias ls='gls -Fa --color'
        else
            alias ls='ls -GFa'
        fi
        ;;
    linux*)
        alias ls='ls -Fa --color'
        ;;
esac

alias ld='ls -ld'          # Show info about the directory
alias lla='ls -lAF'        # Show hidden all files
alias ll='ls -lF'          # Show long file information
alias la='ls -AF'          # Show hidden files
alias lx='ls -lXB'         # Sort by extension
alias lk='ls -lSr'         # Sort by size, biggest last
alias lc='ls -ltcr'        # Sort by and show change time, most recent last
alias lu='ls -ltur'        # Sort by and show access time, most recent last
alias lt='ls -ltr'         # Sort by date, most recent last
alias lr='ls -lR'          # Recursive ls

## cp
alias cp="${ZSH_VERSION:+nocorrect} cp -i"

## mv
alias mv="${ZSH_VERSION:+nocorrect} mv -i"

## mkdir
alias mkdir="${ZSH_VERSION:+nocorrect} mkdir"

## grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

## zmv -- rename multiple files
alias zmv='noglob zmv -W'

## ps
alias psa='ps auxw'

# Display the the first 8 processes with highest CPU usage
function pst() {
    psa | head -n 1
    psa | sort -r -n +2 | grep -v "ps -auxww" | grep -v grep | head -n 8
}

# Display the the first 8 processes with highest memory usage
function psm() {
    psa | head -n 1
    psa | sort -r -n +3 | grep -v "ps -auxww" | grep -v grep | head -n 8
}

# GREP process
function psg() {
    psa | head -n 1
    psa | grep $* | grep -v "ps -auxww" | grep -v grep
}

## less
#alias less="$PAGER"
alias les="less"	# for typo

## sudo
#
# The first word of each simple command, if unquoted, is checked to see
# if it has an alias. [...] If the last character of the alias value is
# a space or tab character, then the next command word following the
# alias is also checked for alias expansion
#
case ${OSTYPE} in
    darwin*) alias sudo="${ZSH_VERSION:+nocorrect} sudo ";;
    linux*)  alias sudo='sudo '
esac

# functions/commands which are always executed background
function gv() { command gv $* & }
function gimp() { command gimp $* & }
function mozzila() { command mozilla $* & }
function xdvi() { command xdvi $* & }
function xpdf() { command xpdf $* & }
function evince() { command evince $* & }
function okular() { command okular $* & }
function acroread() { command acroread $* & }
function display() { command display $* & }
function mpg321() { command mpg321 -s $* | esdcat & }

# --- ranger CLI filer
# Prevent nested ranger instances
function ranger() {
    if [ -z "${RANGER_LEVEL}" ]; then
        command ranger $@
    else
        exit
    fi
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

## tmux
# XDG compliancy fix for Tmux
alias tmux="tmux -f ${XDG_CONFIG_HOME}/tmux/tmux.conf"

# }}}

##=====================================================================
## Keybinding
##=====================================================================
# {{{

# Emacs like keybindings as default
bindkey -e

# complete on tab, leave expansion to _expand
bindkey '^I' complete-word

# M-h run-help -> backward-kill-word
bindkey "^[h" backward-kill-word  # Bind to M-h
bindkey "^[^H" run-help           # Bind to C-M-h

# zsh-history-substring-search
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

if (( ${+commands[fzf]} )); then
    # Load custom functions
    autoload -Uz fzf-cd-ghq-repo fzf-cdr
    zle -N fzf-cd-ghq-repo
    zle -N fzf-cdr

    # Keybind
    bindkey '^I'  fzf-completion
    bindkey '^R'  fzf-history-widget
    bindkey '^T'  fzf-file-widget
    bindkey '\ec' fzf-cd-widget

    bindkey '^G'  fzf-cd-ghq-repo
    bindkey '^]'  fzf-cdr
fi

# }}}

##=====================================================================
## Prompt
##=====================================================================
##{{{
# powerline-rs is fast!
if (( ${+commands[powerline-rs]} )); then
    function powerline_precmd() {
        PS1="$(powerline-rs --shell zsh $?)"
    }

    function install_powerline_precmd() {
        for s in "${precmd_functions[@]}"; do
            if [ "$s" = "powerline_precmd" ]; then
                return
            fi
        done
        precmd_functions+=(powerline_precmd)
    }

    if [ "${TERM}" != "linux" ]; then
        install_powerline_precmd
    fi
fi

## --- Statistics
#
# Print execution statistics upon completion whenever a command takes more
# than $REPORTTIME sec.
#
REPORTTIME=5

# Customize print format
# TIMEFMT="\
#     The name of this job.             :%J
#     CPU seconds spent in user mode.   :%U
#     CPU seconds spent in kernel mode. :%S
#     Elapsed time in seconds.          :%E
#     The  CPU percentage.              :%P"

## --- Watching login/logout
# Watching other users
watch=(notme)
# Check every 60 seconds.
LOGCHECK=60
# Format message printed on login/logout
WATCHFMT="%(a:${fg[blue]}Hello %n [%m] [%t]:${fg[red]}Bye %n [%m] [%t])"

##}}}

##=====================================================================
## Machine local settings
##=====================================================================
loadlib "${ZDOTDIR:-$HOME}/.zshrc_local"

##=====================================================================
## Profiling
##=====================================================================
#if type zprof > /dev/null 2>&1; then
#    zprof | less
#fi

if [[ "$PROFILE_STARTUP" == true ]]; then
    unsetopt xtrace
    exec 2>&3 3>&-
fi

# ----- End of zshrc -----
# vim: foldmethod=marker
