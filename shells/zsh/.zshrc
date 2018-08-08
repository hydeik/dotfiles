# Set the default permission of file to 0644 (rw-r--r--)
umask 022
# Do not dump `core` file
limit coredumpsize 0

# # Return if zsh is called from Vim
# if [[ -n $VIMRUNTIME ]]; then
#     return 0
# fi

### Tmux
# Attach tmux session automatically if exists, create new session otherwise.
if (( ${+commands[tmux]} )); then
    export TMUX_AUTO_START=true
    export PERCOL=fzf
    source ${ZDOTDIR}/tmux_auto.zsh
fi


## zplugin -- An elastic and fast Zshell plugin manager
local -A ZPLGM  # initial Zplugin's hash definition
ZPLGM[BIN_DIR]=${ZDOTDIR}/.zplugin/bin
ZPLGM[HOME_DIR]=${ZDOTDIR}/.zplugin
ZPLGM[ZCOMPDUMP_PATH]=${XDG_CACHE_HOME}/zsh/zcompdump

if [[ -f ${ZPLGM[BIN_DIR]}/zplugin.zsh ]]; then
    source "${ZPLGM[BIN_DIR]}/zplugin.zsh"
    # Load zplugin configuration file. This will call compinit
    source "${ZDOTDIR}/zplugin.rc.zsh"
    # if you `source` the zplugin.zsh after calling compinit,
    # then add those two lines:
    # autoload -Uz _zplugin
    # (( ${+_comps} )) && _comps[zplugin]=_zplugin
fi

## set keychain
if (( ${+commands[keychain]} )); then
    keychain ${HOME}/.ssh/id_ed25519 ${HOME}/.ssh/id_github_ed25519 2> /dev/null
    source ${HOME}/.keychain/${HOST}-sh
fi

## prompt (requires powerline-rs)
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

    if [ "$TERM" != "linux" ]; then
        install_powerline_precmd
    fi
fi

#
# stty    erase   '^H'
# stty    intr    '^C'
# stty    susp    '^Z'
#

#### time
REPORTTIME=8                    # CPUを8秒以上使った時は time を表示
TIMEFMT="\
    The name of this job.             :%J
    CPU seconds spent in user mode.   :%U
    CPU seconds spent in kernel mode. :%S
    Elapsed time in seconds.          :%E
    The  CPU percentage.              :%P"

#### ログインの監視
# log コマンドでも情報を見ることができる
watch=(notme) # (all:全員、notme:自分以外、ユーザ名,@ホスト名、%端末名(列挙；空白区切り、繋げて書くとAND条件)
LOGCHECK=60                     # チェック間隔[秒]
WATCHFMT="%(a:${fg[blue]}Hello %n [%m] [%t]:${fg[red]}Bye %n [%m] [%t])"
# ↑では、a (ログインかログアウトか)で条件分岐している
# %(a:真のメッセージ:偽のメッセージ)
# a,l,n,m,M で利用できる。
# ■使える特殊文字
# %n    ユーザ名
# %a    ログイン/ログアウトに応じて「logged on」/「logged off」
# %l    利用している端末名
# %M    長いホスト名
# %m    短いホスト名
# %S〜%s        〜の間を反転
# %U〜%u        〜の間をアンダーライン
# %B〜%b        〜の間を太字
# %t,%@ 12時間表記の時間
# %T    24時間表記の時間
# %w    日付(曜日 日)
# %W    日付(月/日/年)
# %D    日付(年-月-日)

##
## Machine local settings
##
if [[ -f ~/.zshrc_local ]]; then
    source ~/.zshrc_local
fi
if [[ -f ${ZDOTDIR}/.zshrc_local ]]; then
    source ${ZDOTDIR}/.zshrc_local
fi

# # for profiling
# if type zprof > /dev/null 2>&1; then
#   zprof | less
# fi
