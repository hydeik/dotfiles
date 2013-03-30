;;; -*- mode: emacs-lisp; coding: utf-8-unix -*-;;
;;;
;;; File: ~/.emacs.d/conf/40_vc.el
;;; Description: Customize VC (version control)
;;;

;;;=============================================================================
;;; VC -- Emacs version control
;;;=============================================================================
(setq make-backup-files t)
(setq backup-directory-alist
      ;; Make Backup files into ~/bak
      (cons (cons "\\.*$" (expand-file-name "~/bak"))
            backup-directory-alist))
(setq version-control t)
(setq kept-new-versions 2)
(setq kept-old-versions 2)
(setq delete-old-versions t)

;;;=============================================================================
;;; Git customization
;;;=============================================================================
;; (el-get 'sync '(git-gutter-fringe magit magithub))

;; (require 'magit nil t)
;; (require 'magithub nil t)
;; (require 'git-gutter-fringe nil t)
(el-get 'sync '(git-gutter-fringe egg))
(require 'git-gutter-fringe nil t)
(require 'egg nil t)
