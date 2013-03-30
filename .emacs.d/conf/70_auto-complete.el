;;; -*- mode: emacs-lisp; coding: utf-8-unix; indent-tabs-mode: nil; -*-
;;;
;;; File: ~/.emacs.d/inits/60_auto-complete.el
;;; Description: Setup Auto Complete
;;;

(el-get 'sync '(auto-complete
                auto-complete-chunk
                auto-complete-clang
                auto-complete-css
                auto-complete-emacs-lisp
                auto-complete-etags
                auto-complete-extension
                auto-complete-latex
                auto-complete-rst
                auto-complete-ruby
                ac-dabbrev
                ac-math
                ac-python))

(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories (expand-file-name "~/.emacs.d/ac-dict"))
  (define-key ac-mode-map  [(control tab)] 'auto-complete)
  (setq ac-delay 0.3)

  ;; Auto Complete Clang
  (if (require 'auto-complete-clang nil t)
      (progn
        ;; Change cc-mode setting
        (defun my-ac-cc-mode-setup ()
          (setq ac-sources (append '(ac-source-clang ac-source-gtags) ac-sources))
          (setq ac-clang-prefix-header "~/.emacs.d/local/clang/stdafx.pch"))
        ;; Location of clang executable
        (setq ac-clang-executable "clang")
        ;; Determines whether to save the buffer when retrieving completions.
        (setq ac-clang-auto-save nil)
        ;; function to return the lang type for option -x
        (setq ac-clang-lang-option-function nil)
        ;; Extra compilation flags to pass to the Clang executable.
        (setq ac-clang-flags '("-Wall" "-std=c++11" "-stdlib=libc++"))
        )
    (defun my-ac-cc-mode-setup ()
      (setq ac-sources (append '(ac-source-gtags) ac-sources)))
    )
  
  ;; Auto Complete source for python
  (require 'ac-python nil t)

  (defun my-ac-config ()
    (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
    (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
    (add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
    (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
    (add-hook 'css-mode-hook 'ac-css-mode-setup)
    (add-hook 'auto-complete-mode-hook 'ac-common-setup)
    (global-auto-complete-mode t))

  (my-ac-config)

  )

