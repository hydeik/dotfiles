;;; -*- mode: emacs-lisp; coding: utf-8-unix; indent-tabs-mode: nil; -*-
;;;
;;; File: ~/.emacs.d/conf/10_history.el
;;; Description: Customize history
;;;

;;; 履歴数を大きくする
(setq history-length 10000)

;;; recenrf - 最近使ったファイルを記憶させる
(el-get 'sync '(recentf-ext))
(require 'recentf)
(require 'recentf-ext nil t)
(setq recentf-save-file (expand-file-name "~/.emacs.d/.recentf"))
(setq recentf-max-saved-items 2000)
(recentf-mode 1)

;;; saveplace - 前回編集していたカーソル位置を記憶
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file "~/.emacs.d/.emacs-places")

