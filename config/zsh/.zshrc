umask 022
limit coredumpsize 0

# Return if zsh is called from Vim
if [[ -n $VIMRUNTIME ]]; then
    return 0
fi

#
# zplug -- Zsh Plugin Manager
#
#export ZPLUG_HOME=/usr/local/opt/zplug
export ZPLUG_HOME=${XDG_DATA_HOME}/zplug/repos/zplug/zplug
if [[ -f ${ZPLUG_HOME}/init.zsh ]]; then
    export ZPLUG_LOADFILE=${ZDOTDIR}/zplug.zsh
    export ZPLUG_USE_CACHE=true
    export ZPLUG_CACHE_DIR=${XDG_CACHE_HOME}/zplug 
    export ZPLUG_REPOS=${XDG_DATA_HOME}/zplug/repos
    #export ZPLUG_BIN=${HOME}/bin

    source ${ZPLUG_HOME}/init.zsh

    # if ! zplug check --verbose; then
    #     printf "Install? [y/N]: "
    #     if read -q; then
    #         echo; zplug install
    #     fi
    #     echo
    # fi

    # zplug load --verbose
    zplug load
fi

# 
# stty    erase   '^H'
# stty    intr    '^C'
# stty    susp    '^Z'
# 
# 
## set keychain
if [[ -x `which keychain` ]]; then
   keychain ${HOME}/.ssh/id_ed25519 ${HOME}/.ssh/id_github_ed25519 2> /dev/null
   source ${HOME}/.keychain/${HOST}-sh
fi


############################################################
## プロンプト設定
# autoload -U colors; colors      # ${fg[red]}形式のカラー書式を有効化
# 
# setopt prompt_subst				# ESCエスケープを有効にする
# 
# if [[ $COLORTERM == 1 ]]; then
#     if [[ $UID == 0 ]] ; then 
# 		PSCOLOR='01;01;31'
#     else
# 		PSCOLOR='01;01;32'		# 下線、緑
#     fi
#     # 右プロンプト
#     RPROMPT=$'%{\e[${PSCOLOR}m%}[%{\e[36m%}%~%{\e[${PSCOLOR}m%}]%{\e[00m%}'
#     PS1=$'%{\e[${PSCOLOR}m%}%n@%m${WINDOW:+"[$WINDOW]"} %{\e[34m%}$ '
# fi
# 1個目の $'...' は 「\e]2;「kterm のタイトル」\a」
# 2個目の $'...' は 「\e]1;「アイコンのタイトル」\a」
# 3個目の $'...' がプロンプト

# \e を ESC コード()で置く必要があるかも
# emacs では C-q ESC, vi では C-v ESC で入力する
#	\e[00m 	初期状態へ
#	\e[01m 	太字	(0は省略可能っぽい)
#	\e[04m	アンダーライン
#	\e[05m	blink(太字)
#	\e[07m	反転
#	\e[3?m	文字色をかえる
#	\e[4?m	背景色をかえる
#		?= 0:黒, 1:赤, 2:緑, 3:黄, 4:青, 5:紫, 6:空, 7:白



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
[[ -f ~/.zshrc_local ]] && . ~/.zshrc_local

# # for profiling
# if type zprof > /dev/null 2>&1; then
#   zprof | less
# fi
