;;; -*- mode: emacs-lisp; coding: utf-8-unix -*-;;
;;;
;;; File: ~/.emacs.d/inits/00_init.el
;;; Description: Basic customization
;;;

;;==============================================================================
;; Basic setup
;;==============================================================================

;;; Highlight region
(setq transient-mark-mode t)

;;; 選択範囲の文字を置き換え
(delete-selection-mode t)

;;; 行頭で "C-k" すると，改行文字も kill する
(setq kill-whole-line 'always)

;;; visible bell
(setq visible-bell t)

;;; yes-or-no -> y-or-n
(fset 'yes-or-no-p 'y-or-n-p)

;;; Tab width
(setq-default tab-width 4)

;;; Use C-h v or `Help->Commands, Variables, Keys->Describe Variable...'
;;; to find out what these variables mean.
(setq find-file-compare-truenames t
      minibuffer-max-depth nil)

;;; テキストを折り返す
(setq truncate-lines t)
(setq truncate-partial-width-windows t)

;;; 値を評価して得られるリストの表示を省略しない
(setq eval-expression-print-level nil)
(setq eval-expression-print-length nil)

;;; find-fileのファイル名補完で大文字小文字を区別しない
(setq read-file-name-completion-ignore-case t)

;;; 圧縮されたファイルを開く (こうしないと圧縮された日本語infoが読めない)
(auto-compression-mode t)

;;; 画像の表示
(if (>= emacs-major-version 21)
    (auto-image-file-mode t))

;;; auto-fill 段落整形時の折り返しの文字数
;; memo: M-q で段落の整形
(setq-default fill-column 80)

;;; 行頭の空白を段落の区切りとして認識させる
(setq paragraph-start '"^\\([ 　・○<\t\n\f]\\|(?[0-9a-zA-Z]+)\\)")

;;; Inhibit startup message
(setq inhibit-startup-screen t)

;;; Inhibit toolbar
(tool-bar-mode 0)

;;; Inhibit scroll-bar
(scroll-bar-mode 0)

;;; Inhibit menu bar
(menu-bar-mode 0)

;;; Display file size on modeline
(size-indication-mode t)

;;; Display clock on modeline
(setq display-time-day-and-date t)
(display-time)

;;; Show line numbers and column numbers
(line-number-mode t)					; show line number on modeline
(column-number-mode t)					; show column number on modeline
(if (require 'linum nil t)
    (global-linum-mode t))
(if (require 'ruler-mode nil t)
    (ruler-mode t))

;;==============================================================================
;; Customize some default keybinds
;;==============================================================================

;; C-h: BackSpace (<= help-for-help)
(keyboard-translate ?\C-h ?\C-?)

;; C-m newline-and-indent (<= newline)
(global-set-key (kbd "C-m") 'newline-and-indent)
;; C-t other-window (<= transpose-chars)
(global-set-key (kbd "C-t") 'other-window)

;; M-?, [f1]: help-for-help
(global-set-key (kbd "M-?") 'help-for-help)
(global-set-key [f1] 'help-for-help)

;; M-h backward-kill-word (<= mark-paragraph)
(global-set-key (kbd "M-h") 'backward-kill-word)
;; M-H mark-paragraph
(global-set-key (kbd "M-H") 'mark-paragraph)
;; M-g goto-line
(global-set-key (kbd "M-g") 'goto-line)

;;; 日本語でインクリメンタルサーチ
(define-key isearch-mode-map (kbd "C-k") 'isearch-edit-string)


;;==============================================================================
;; Customize basic packages
;;==============================================================================

;;; filecache
(when (require 'filecache nil t)
  (file-cache-add-directory-list
   (list "~"
         "~/bin"
         "~/program/"
         ))
  (define-key minibuffer-local-completion-map
    "\C-c\C-i" 'file-cache-minibuffer-complete))

;; 対応する括弧の強調
(show-paren-mode t)
(setq show-paren-style 'mixed)
(setq show-paren-style 'expression)
;; ;; マッチした場合の色
;; (set-face-background 'show-paren-match-face "dodger blue")
;; (set-face-foreground 'show-paren-match-face "white")
;; ;; マッチしていない場合の色
;; (set-face-background 'show-paren-mismatch-face "Red")
;; (set-face-foreground 'show-paren-mismatch-face "black")

;;; whitespace -- 空白や長すぎる行を視覚化する
(require 'whitespace)
(setq whitespace-line-column 80)
(setq whitespace-style '(face              ; faceを使って視覚化する
                         tabs
                         tab-mark
                         spaces
                         space-mark
                         trailing          ; 行末の空白を対象とする
                         lines-tail        ; 長すぎる行のうち
                                        ; whitespace-line-column
                                        ; 以降のみを対象とする
                         space-before-tab  ; タブの前にあるスペースを対象とする
                         space-after-tab ; タブの後にあるスペースを対象とす
                         ))
;; (setq whitespace-style
;;       '(tabs tab-mark spaces space-mark))
;; 全角スペースを視覚化
(setq whitespace-space-regexp "\\(\x3000+\\)")
(setq whitespace-display-mappings
      '((space-mark ?\x3000 [?\□])
        (tab-mark   ?\t   [?\xBB ?\t])
        ))
;; デフォルトで視覚化を有効にする。
(global-whitespace-mode 1)

;;; CUA mode -- 矩形選択用
(cua-mode t)
(setq cua-enable-cua-keys nil)
