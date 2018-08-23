##
## Options
##

# --- History
setopt extended_history         # コマンドの開始時刻と経過時間を登録
setopt hist_ignore_dups         # 直前のコマンドと同一ならば登録しない
setopt hist_ignore_all_dups     # 登録済コマンド行は古い方を削除
setopt hist_reduce_blanks       # 余分な空白は詰めて登録(空白数違い登録を防ぐ)
setopt hist_no_store            # historyコマンドは登録しない
setopt hist_ignore_space        # コマンド行先頭が空白の時登録しない(直後ならば呼べる)
#setopt append_history          # zsh を終了させた順にファイルに記録(デフォルト)
#setopt inc_append_history      # 同上、ただしコマンドを入力した時点で記録
setopt share_history            # ヒストリの共有。(append系と異なり再読み込み不要、これを設定すれば append 系は不要)

# --- Globbing
setopt extended_glob            # 拡張グロブ
setopt numeric_glob_sort        # 数字を数値と解釈して昇順ソートで出力

# --- Completion
setopt list_packed              # 補完候補リストを詰めて表示
setopt list_types               # 補完候補にファイルの種類も表示する
setopt print_eight_bit          # 補完候補リストの日本語を適正表示
#setopt menu_complete            # 1回目のTAB で補完候補を挿入。表示だけの方が好き
setopt correct                  # スペルミス補完

# --- Directory move
setopt auto_cd                  # 第1引数がディレクトリだと cd を補完
setopt auto_pushd               # cd -[TAB] でこれまでに移動したディレクトリ一覧を表示
setopt pushd_to_home            # 引数なしpushdで$HOMEに戻る(直前dirへは cd - で)
setopt pushd_ignore_dups        # ディレクトリスタックに重複する物は古い方を削除
#setopt pushd_silent   # pushd, popd の度にディレクトリスタックの中身を表示しない

# --- File
#setopt rm_star_silent          # rm * で本当に良いか聞かずに実行
setopt rm_star_wait             # rm * の時に 10秒間何もしない

# --- Misc
#setopt no_clobber               # 上書きリダイレクトの禁止
#setopt no_unset                 # 未定義変数の使用の禁止
setopt no_hup                   # logout時にバックグラウンドジョブを kill しない
setopt no_beep                  # コマンド入力エラーでBEEPを鳴らさない

setopt no_checkjobs             # exit 時にバックグラウンドジョブを確認しない
#setopt ignore_eof              # C-dでlogoutしない(C-dを補完で使う人用)
setopt interactive_comments     # コマンド入力中のコメントを認める
#setopt chase_links             # リンク先のパスに変換してから実行。
# setopt sun_keyboard_hack      # SUNキーボードでの頻出 typo ` をカバーする

