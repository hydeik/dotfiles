;;; -*- mode: emacs-lisp; coding: utf-8-unix -*-;;
;;;
;;; File: ~/.emacs.d/conf/30_ddskk.el
;;; Description: Japanese IME
;;;

;;; DDSKK
(el-get 'sync '(ddskk))
(when (require 'skk-autoloads nil t)
  (global-set-key "\C-x\C-j" 'skk-mode)
  (global-set-key "\C-xj" 'skk-auto-fill-mode)
  ;;(global-set-key "\C-xt" 'skk-tutorial)
  (require 'skk-leim nil t)
  (setq default-input-method 'japanese-skk)
  (setq skk-init-file "~/.emacs.d/.skk")
  (add-hook 'isearch-mode-hook
			(lambda () (and (boundp 'skk-mode) skk-mode
							(skk-isearch-mode-setup))))
  (add-hook 'isearch-mode-end-hook
			(lambda ()
			  (and (featurep 'skk-isearch) (skk-isearch-mode-cleanup))))
  (setq skk-isearch-start-mode 'latin)
  )

