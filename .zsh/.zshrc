umask 022
limit coredumpsize 0

# Return if zsh is called from Vim
if [[ -n $VIMRUNTIME ]]; then
    return 0
fi

# tmux_automatically_attach attachs tmux session
# automatically when your are in zsh
# $DOTPATH/bin/tmuxx

if [[ -f ~/.zplug/init.zsh ]]; then
    export ZPLUG_LOADFILE=~/.zsh/zplug.zsh
    # For development version of zplug
    # source ~/.zplug/init.zsh
    source ~/dev/src/github.com/zplug/zplug/init.zsh

    if ! zplug check --verbose; then
        printf "Install? [y/N]: "
        if read -q; then
            echo; zplug install
        fi
        echo
    fi
    zplug load
fi

##============================================================================
## Keybinding
##============================================================================
bindkey -e   # emacs like keybindings
bindkey '^I' complete-word   # complete on tab, leave expansion to _expand

# history-substring-search
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

##============================================================================
## setupt
##============================================================================

# カレントディレクトリに候補がない場合のみ cdpath 上のディレクトリを候補
# zstyle ':completion:*:cd:*' tag-order local-directories path-directories
# cf. zstyle ':completion:*:path-directories' hidden true
# cf. cdpath 上のディレクトリは補完候補から外れる

## 補完時に大小文字を区別しない
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#### option, limit, bindkey
setopt extended_history         # コマンドの開始時刻と経過時間を登録
setopt hist_ignore_dups         # 直前のコマンドと同一ならば登録しない
setopt hist_ignore_all_dups     # 登録済コマンド行は古い方を削除
setopt hist_reduce_blanks       # 余分な空白は詰めて登録(空白数違い登録を防ぐ)
#setopt append_history          # zsh を終了させた順にファイルに記録(デフォルト)
#setopt inc_append_history      # 同上、ただしコマンドを入力した時点で記録
setopt share_history            # ヒストリの共有。(append系と異なり再読み込み不要、これを設定すれば append 系は不要)
setopt hist_no_store            # historyコマンドは登録しない
setopt hist_ignore_space        # コマンド行先頭が空白の時登録しない(直後ならば呼べる)


setopt list_packed              # 補完候補リストを詰めて表示
setopt list_types               # 補完候補にファイルの種類も表示する
setopt print_eight_bit          # 補完候補リストの日本語を適正表示
#setopt menu_complete           # 1回目のTAB で補完候補を挿入。表示だけの方が好き
#setopt no_clobber               # 上書きリダイレクトの禁止
#setopt no_unset                 # 未定義変数の使用の禁止
setopt no_hup                   # logout時にバックグラウンドジョブを kill しない
setopt no_beep                  # コマンド入力エラーでBEEPを鳴らさない

setopt extended_glob            # 拡張グロブ
setopt numeric_glob_sort        # 数字を数値と解釈して昇順ソートで出力
setopt auto_cd                  # 第1引数がディレクトリだと cd を補完
setopt correct                  # スペルミス補完
setopt no_checkjobs             # exit 時にバックグラウンドジョブを確認しない
#setopt ignore_eof              # C-dでlogoutしない(C-dを補完で使う人用)
setopt auto_pushd               # cd -[TAB] でこれまでに移動したディレクトリ一覧を表示
setopt pushd_to_home            # 引数なしpushdで$HOMEに戻る(直前dirへは cd - で)
setopt pushd_ignore_dups        # ディレクトリスタックに重複する物は古い方を削除
#setopt pushd_silent   # pushd, popd の度にディレクトリスタックの中身を表示しない
setopt interactive_comments     # コマンド入力中のコメントを認める
#setopt rm_star_silent          # rm * で本当に良いか聞かずに実行
setopt rm_star_wait             # rm * の時に 10秒間何もしない
#setopt chase_links             # リンク先のパスに変換してから実行。
# setopt sun_keyboard_hack      # SUNキーボードでの頻出 typo ` をカバーする

# 
# stty    erase   '^H'
# stty    intr    '^C'
# stty    susp    '^Z'
# 
# 
# ## set keychain
# if [[ -x `which keychain` ]]; then
#    keychain ${HOME}/.ssh/id_rsa ${HOME}/.ssh/id_ecdsa ${HOME}/.ssh/id_ecdsa_github 2> /dev/null
#    source ${HOME}/.keychain/${HOST}-sh
# fi
# 

# ############################################################
# ## プロンプト設定
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
# # 1個目の $'...' は 「\e]2;「kterm のタイトル」\a」
# # 2個目の $'...' は 「\e]1;「アイコンのタイトル」\a」
# # 3個目の $'...' がプロンプト
# 
# # \e を ESC コード()で置く必要があるかも
# # emacs では C-q ESC, vi では C-v ESC で入力する
# #	\e[00m 	初期状態へ
# #	\e[01m 	太字	(0は省略可能っぽい)
# #	\e[04m	アンダーライン
# #	\e[05m	blink(太字)
# #	\e[07m	反転
# #	\e[3?m	文字色をかえる
# #	\e[4?m	背景色をかえる
# #		?= 0:黒, 1:赤, 2:緑, 3:黄, 4:青, 5:紫, 6:空, 7:白
# 
# 

##============================================================================
## aliases
##============================================================================

#### PAGER
#alias less="$PAGER"
alias les="less"	# for typo

#### man
if [[ -x `which jman` ]]; then
    alias man="jman"
fi

#### gnuplot with rlwrap
if [[ -x `which rlwrap` ]]; then
    alias gnuplot="rlwrap -a -c gnuplot"
fi

#### emacs
#if [ -x $HOME/bin/select-emacs ]; then
#    alias emacs='$HOME/bin/select-emacs'
#    alias emasc='$HOME/bin/select-emacs'
#fi

#### ps
if [[ $ARCHI == "irix" ]]; then
    alias psa='ps -ef'
else; 
    alias psa='ps auxw'
fi
function pst() {				# CPU 使用率の高い方から8つ
    psa | head -n 1
    psa | sort -r -n +2 | grep -v "ps -auxww" | grep -v grep | head -n 8
}
function psm() {				# メモリ占有率の高い方から8つ
    psa | head -n 1
    psa | sort -r -n +3 | grep -v "ps -auxww" | grep -v grep | head -n 8
}
function psg() {
    psa | head -n 1
    psa | grep $* | grep -v "ps -auxww" | grep -v grep
}

#### ls
#### dircolor
# if [[ -x `which dircolors` ]] && [[ -e $HOME/.dir_colors ]]; then
#     eval `dircolors $HOME/.dir_colors` # 色の設定
# fi

# BSD LSCOLORS
export LSCOLORS=ExgxFxdxcxegefabagacad
# Linux LS_COLORS
export LS_COLORS='di=1;;40:ln=36;40:so=1;;40:pi=33;40:ex=32;40:bd=34;46:cd=34;45:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
export ZLS_COLORS=$LS_COLORS
# 一部のシェルコマンドの出力に色を付け
export CLICOLOR=true
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

#### Aliases
alias ls="ls -aF"
alias lscolor='ls -aF'
alias kls='ls'
# alias sl='ls'
alias sls='ls'
alias l='ls'

#### command
alias cp='cp -iv'
#alias du='du -k'
#alias mv='mv -iv'
alias xcalc='xcalc &'
alias xterm='xterm &'
alias bell="echo '\a'"

#### switch keymaps
alias asdf="xmodmap .Xmodmap-dvorak"
alias aoeu="xmodmap .Xmodmap-qwerty"

#### switch compiler
alias usegnu="CC=gcc CXX=g++ FC=g77"
alias useintel="CC=icc CXX=icpc FC=ifort F90=ifort"
alias usepgi="CC=pgcc CXX=pgCC FC=pgf77 F90=pgf90"
# 常にバックグラウンドで実行
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

# バックアップファイルを作成
function bak() {
    for i in $@ ; do
        if [[ -e $i.bak ]] || [[ -d $i.bak ]]; then
            echo "$i.bak already exist"
        else
            command cp -ir $i $i.bak
        fi
    done
}

# ごみ箱の実装
function rm() {
    if [[ -d ~/.trash ]]; then
        DATE=`date "+%y%m%d-%H%M%S"`
        mkdir ${HOME}/.trash/$DATE
        for i in $@; do
            # 対象が ~/.trash/ 以下なファイルならば /bin/rm を呼び出したいな
            if [[ -e $i ]]; then
                rmcommand="mv $i ~/.trash/$DATE/"
                eval "$rmcommand"
                unset rmcommand
            else 
                echo "$i : not found"
            fi
        done
        unset DATE
    else
        /bin/rm $@
    fi
}

#function emacs() {
#    gnuclient "$@" 2> /dev/null || command emacs "$@" 2> /dev/null &
#}

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

############################################################
## ホスト依存の設定
# if [ $ARCHI = "cygwin"  ]; then
#     zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'	# 補完時に大小文字を区別しない
# fi
if [[ $ARCHI == "irix" ]] || [[ $ARCHI == "osf1" ]]; then
    if [[ TERM == "Eterm" ]]; then
        export TERM="vt102"
    else
        export TERM="xterm"
    fi
    alias ls="ls -F"
fi

############################################################
## 個人情報を含む設定
#if [ -e ~/.zshrc_private ]; then
#    source ~/.zshrc_private
#fi

#### end of file ###########################################
