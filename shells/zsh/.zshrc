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

## Zplug
export ZPLUG_HOME="${ZDOTDIR:-$HOME}/.zplug"
export ZPLUG_USE_CACHE=true
export ZPLUG_LOADFILE="${ZDOTDIR}/zplug_plugins.zsh"
if [[ ! -f "${ZPLUG_HOME}/init.zsh" ]]; then
    # Install zplug
    git clone https://github.com/zplug/zplug "${ZPLUG_HOME}"
    source "${ZPLUG_HOME}/init.zsh" && zplug update --self
fi

source "${ZPLUG_HOME}/init.zsh"

if [[ "$ZPLUG_LOADFILE" -nt "$ZPLUG_CACHE_DIR/interface" || ! -f "$ZPLUG_CACHE_DIR/interface" ]]; then
    zplug check || zplug install
fi

if __zplug::core::cache::diff; then
    __zplug::core::load::from_cache
else
    zplug load
fi

for conf in ${ZDOTDIR}/rc/<->_*.zsh; do
    source "${conf}"
done

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
loadlib "${ZDOTDIR:-$HOME}/.zshrc_local"

##
## Profiling
##
#if type zprof > /dev/null 2>&1; then
#  zprof | less
#fi
