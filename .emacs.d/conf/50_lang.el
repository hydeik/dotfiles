;;; -*- mode: emacs-lisp; coding: utf-8-unix; indent-tabs-mode: nil; -*-
;;;
;;; File: ~/.emacs.d/conf/50_lang.el
;;; Description: Customize major mode for programing languages
;;;

;;;=============================================================================
;;; External packages
;;;=============================================================================
(el-get 'sync '(cmake-mode yaml-mode))

;;;=============================================================================
;;; cc-mode
;;;=============================================================================

;; C/C++ 用のカスタマイズ
(defconst my-c-style
  '(
    (c-basic-offset             . 4)        ; 基本オフセット量の設定
    (c-tab-always-indent        . t)        ; tab キーでインデントを実行
    (c-comment-only-line-offset . 0)        ; コメント行のオフセット量の設定
    (c-block-comment-prefix . "* ")         ; ブロックコメントの継続行の書式
    (c-indent-comments-syntactically-p . t) ; コメント行もインデント
    (c-backslash-column . 32)           ; コメントのバックスラッシュ開始の最低値
    (c-backslash-max-column . 100)      ; ラインコメントの最後尾のカラム

    ;; カッコ前後の自動改行処理の設定
    (c-hanging-braces-alist
     . (
        (class-open before after)       ; クラス宣言の'{'の後
        (class-close before)            ; クラス宣言の'}'の前
        (defun-open before after)       ; 関数宣言の'{'の前
        (defun-close before after)      ; 関数宣言の'}'の後
        (inline-open before after)      ; クラス内のインライン関数宣言の'{'の
        (inline-close before after)     ; クラス内のインライン関数宣言の'}'の後
        (brace-list-open before)        ; 列挙型、配列宣言の'{'の前後
        (brace-list-close after)        ; 列挙型、配列宣言の'}'の後
        (block-open after)              ; ステートメントの'{'の後
        (block-close before after)      ; ステートメントの'}'前後
        (substatement-open after)       ; サブステートメント(if 文等)の'{'の後
        (substatement-close before after) ; サブステートメント(if 文等)の'}'の前
        (statement-case-open after)       ; case 文の'{'の後
        (extern-lang-open after)          ; 他言語へのリンケージ宣言の'{'の前後
        (extern-lang-close after)         ; 他言語へのリンケージ宣言の'}'の前後
        ))

    ;; コロン前後の自動改行処理の設定
    (c-hanging-colons-alist
     . (
        (case-label after)              ; case ラベルの':'の後
        (label after)                   ; ラベルの':'の後
        (access-label after)            ; アクセスラベル(public等)の':'の後
        (member-init-intro after)       ; コンストラクタでのメンバー初期化
                                        ; リストの先頭の':'では改行しない
        (inher-intro before)            ; クラス宣言での継承リストの先頭の
                                        ; ':'では改行しない
        ))

    ;; 挿入された余計な空白文字のキャンセル条件の設定
    ;; 下記の*を削除する
    (c-cleanup-list
     . (
        ;;  brace-else-brace                ; else の直前
        ;;                                      ; "} * else {"  ->  "} else {"
        ;;  brace-elseif-brace              ; else if の直前
        ;;                                      ; "} * else if (.*) {"
        ;;                                      ; ->  } "else if (.*) {"
        empty-defun-braces              ; 空のクラス・関数定義の'}' の直前
        ;;；"{ * }"  ->  "{}"
        defun-close-semi                ; クラス・関数定義後の';' の直前
                                        ; "} * ;"  ->  "};"
        list-close-comma                ; 配列初期化時の'},'の直前
                                        ; "} * ,"  ->  "},"
        scope-operator                  ; スコープ演算子'::' の間
                                        ; ": * :"  ->  "::"
        ))

    ;; オフセット量の設定
    ;; 必要部分のみ抜粋(他の設定に付いては info 参照)
    ;; オフセット量は下記で指定
    ;; +  c-basic-offsetの 1倍, ++ c-basic-offsetの 2倍
    ;; -  c-basic-offsetの-1倍, -- c-basic-offsetの-2倍
    (c-offsets-alist
     . (
        (comment-intro          . 0)    ; コメント開始
        (arglist-intro          . +)    ; 引数リストの開始
        ;;(arglist-close          . c-lineup-arglist)   ; 引数リストの終了
        (arglist-close          . 0)    ; 引数リストの終了
        (substatement-open      . 0)    ; サブステートメントの開始
        (statement-cont         . ++)   ; ステートメントの継続
        (case-label             . 0)    ; case 文のラベル
        (label                  . 0)    ; ラベル行
        (block-open             . 0)    ; ブロックの開始行
        (member-init-cont       . c-lineup-multi-inher) ; メンバオブジェクトの初期化リスト
        (inline-open            . 0)                    ; 関数の開始
        (inline-close           . 0)
        (innamespace            . 0)
        (template-args-cont     (c-lineup-template-args +))
        ;;(template-args-cont     . +)
        ))

    (c-doc-comment-style . javadoc)     ; ドキュメント用コメントのスタイル
    )
  "My C Programming Style")

;; hook の設定
(add-hook 'c-mode-common-hook
          (lambda ()
            ;; 次のスタイルがデフォルトで用意されているスタイル
            ;;   * gnu:インデントは 2 ．GNU の推奨スタイル
            ;;   * k&r:インデントは 5 ．K&R のスタイル
            ;;   * bsd:インデントは 8 ．BSD のスタイル("Allman style")
            ;;   * stroustrup:インデントは 4 ． Bjarne Stroustrup による，「プロ
            ;;   グラミング言語 C++ 」のスタイル
            ;;   * whitesmith:インデントは 4 ． P ・ J ・プローガーのスタイル．
            ;;   * ellemtel:インデントは 3 ．Programming in C++ Rules and Recommendations で提案されているスタイル．
            ;;   * linux:インデントは 8 ． Linux のスタイル
            ;;   * cc-mode:インデントは 4 ． cc-mode オリジナル
            ;;   * python:インデントは 8 ． Python 用のスタイル
            ;;   * java:インデントは 4 ． JAVA 用のスタイル．
            ;; java style を使用
            ;; (c-set-style "java")
            ;; my-c-style を登録して有効にする場合
            (c-add-style "my-c-style" my-c-style t)
            (c-set-style "my-c-style")

            (setq-default fill-column 80) ; 段落整形時の折り返しの文字数
            (setq indent-tabs-mode nil)   ; Tabの代わりにスペースでインデント
            (setq c-echo-syntactic-information-p t) ; インデント時に構文解析情報を表示する
            (setq c-toggle-auto-state t) ; 自動改行(auto-newline)を有効にする
            (setq c-toggle-hungry-state t) ; 連続する空白の一括削除(hungry-delete)を有効にする
            (setq c-toggle-hungry-state t) ; 連続する空白の一括削除(hungry-delete)を有効にする
            (setq c-hanging-semi&comma-criteria nil) ; セミコロンで自動改行しない
            (subword-mode 1)                         ; CamelCase

            ;; キーバインドの追加
            ;; ------------------
            ;; C-m        改行＋インデント
            ;; C-h        空白の一括削除
            ;; (define-key c-mode-base-map "\C-m" 'newline-and-indent)
            (define-key c-mode-base-map "\C-h" 'c-electric-backspace)

            ))


;;;=============================================================================
;;; Fortran
;;;=============================================================================

;; fortran-mode
(add-hook 'fortran-mode-hook
          (lambda ()
            ;; インデントの変更
            (setq fortran-continuation-indent 4
                  fortran-structure-indent 2
                  fortran-do-indent 2
                  fortran-if-indent 2)
            (fortran-auto-fill-mode 1) ;; wrap lines in 72 columns
            ))

;; f90-mode
(add-hook 'f90-mode-hook
          (lambda ()
            (setq
             ;; キーワードの最初の1文字を大文字で
             f90-auto-keyword-case 'downcase-word
             ;; 継続行の最初に"&"を追加
             f90-beginning-ampersand t
             ;; インデントの変更
             f90-continuation-indent 4
             f90-do-indent 2
             f90-if-indent 2
             f90-type-indent 2
             f90-program-indent 2
             f90-leave-line-no nil)
            (setq comment-column 35)
            ))

;;;=============================================================================
;;; Ruby mode
;;;=============================================================================
(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))

(add-hook 'ruby-mode-hook
          '(lambda ()
             (setq tab-width 2)
             (setq ruby-indent-level tab-width)
             (setq ruby-deep-indent-paren-style nil)
             (define-key ruby-mode-map "\C-m"
               'ruby-reindent-then-newline-and-indent)))
;;;=============================================================================
;;; Python mode
;;;=============================================================================
(autoload 'python-mode "python-mode" "Mode for editing python source files" t)
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(add-to-list 'auto-mode-alist '("Sconscript$" . python-mode))
;; NOTE: further configuration in [[~/.emacs.d/conf/60_auto-complete.el]]

;;;=============================================================================
;;; CMake mode
;;;
;;; Provides syntax highlighting and indentation for CMakeLists.txt and *.cmake
;;; source files. <http://www.cmake.org/CMakeDocs/cmake-mode.el>
;;; ============================================================================
(when (require 'cmake-mode nil t)
  (setq auto-mode-alist
        (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                  ("\\.cmake\\'" . cmake-mode))
                auto-mode-alist)))

;;;=============================================================================
;;; YAML mode -- YAML Ain't Markup Language
;;;  <http://yaml-mode.clouder.jp/>
;;;=============================================================================
(when (require 'yaml-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
  (add-hook 'yaml-mode-hook
            '(lambda ()
               (define-key yaml-mode-map "\C-m" 'newline-and-indent)))
  )

