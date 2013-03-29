;;; -*- mode: emacs-lisp; coding: utf-8-unix -*-;;
;;;
;;; File: ~/.emacs.d/conf/20_migemo.el
;;; Description: Setup migemo
;;;

;; NOTE: download
;; https://github.com/Hideyuki-SHIRAI/migemo-for-ruby1.9/blob/master/migemo.el.in
;; as migemo.el and put into the directory in the load-path.

(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))
;; migemo-dict のパスを指定
(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)
;; キャッシュ機能を利用する
(setq migemo-use-pattern-alist t)
(setq migemo-use-frequent-pattern-alist t)
(setq migemo-pattern-alist-length 1024)
;; 起動時に初期化も行う
(load-library "migemo")
(migemo-init)

