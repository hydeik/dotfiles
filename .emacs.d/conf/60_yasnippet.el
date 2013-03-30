;;; -*- mode: emacs-lisp; coding: utf-8-unix; indent-tabs-mode: nil; -*-
;;;
;;; File: ~/.emacs.d/conf/60_yasnippet.el
;;; Description: Setup Yasnippet
;;;

(el-get 'sync '(yasnippet))

(when (require 'yasnippet nil t)
  (setq yas-snippet-dirs
        '("~/.emacs.d/local/yasnippet/snippets" ;; Location of private snippets
          "~/.emacs.d/el-get/yasnippet/snippets" ;; Location of default snippets
          ))
  (yas-global-mode 1)

  (custom-set-variables '(yas-trigger-key "TAB"))
  )

