;;; -*- mode: emacs-lisp; coding: utf-8-unix -*-;;
;;;
;;; File: ~/.emacs.d/cocoa-emacs-cofig.el
;;; Description: Setup file for GNU Emacs on Mac OSX
;;;

;; Change modifier keys
;; command -> meta, option -> super
(when (>= emacs-major-version 23)
  (setq ns-command-modifier (quote meta))
  (setq ns-alternate-modifier (quote super))
  )

;; Font
(create-fontset-from-ascii-font "Monaco-14:weight=normal:slant=normal" nil "monacomarugo")
(set-fontset-font "fontset-monacomarugo"
                  'unicode
                  (font-spec :family "Hiragino Maru Gothic ProN" :size 16)
                  nil
                  'append)
(add-to-list 'default-frame-alist '(font . "fontset-monacomarugo"))

(modify-all-frames-parameters (list (cons 'alpha  '(80 60 50 30))))

;; avoid hiding with M-h
(setq mac-pass-command-to-system nil)

