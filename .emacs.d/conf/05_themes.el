;;; -*- mode: emacs-lisp; coding: utf-8-unix; indent-tabs-mode: nil; -*-
;;;
;;; File: ~/.emacs.d/conf/05_themes.el
;;; Description: Customize Emacs themes
;;;

(el-get 'sync '(solarized-theme))

;; (load-theme 'solarized-light t)
(load-theme 'solarized-dark t)

;; Change light/dark themes interactively
(defun light-theme ()
  (interactive)
  (load-theme 'solarized-light t))

(defun dark-theme ()
  (interactive)
  (load-theme 'solarized-dark t))
