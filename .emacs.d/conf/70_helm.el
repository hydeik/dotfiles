;;; -*- mode: emacs-lisp; coding: utf-8-unix; indent-tabs-mode: nil; -*-
;;;
;;; File: ~/.emacs.d/conf/70_helm.el
;;; Description: Setup helm
;;;

;; NOTE -- typo in el-get recipe file helm-c-moccur 
(el-get 'sync '(helm
                helm-c-moccur
                helm-c-yasnippet
                helm-descbinds
                helm-gist
                helm-gtags
                helm-ls-git
                helm-migemo))

(when (require 'helm-config nil t)
  (require 'helm-command nil t)
  (setq helm-idle-delay 0.1)
  (setq helm-input-idle-delay 0)
  (setq helm-candidate-number-limit 300)
  (setq helm-samewindow nil)
  (setq helm-quick-update t)

  ;; Change face for dark color theme
  (set-face-background 'helm-selection "blue")
  
  ;; Keybindings
  (global-set-key (kbd "C-;") 'helm-mini)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)
  (global-set-key (kbd "C-M-z") 'helm-resume)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-set-key (kbd "C-x C-b") 'helm-buffers-list)
  (define-key helm-map (kbd "C-M-n") 'helm-next-source)
  (define-key helm-map (kbd "C-M-p") 'helm-previous-source)
  (helm-mode 1)

  ;; helm-descbinds
  (when (require 'helm-descbinds nil t)
    (helm-descbinds-mode))

  ;; helm-c-moccur
  (when (require 'helm-c-moccur nil t)
    (global-set-key (kbd "M-o") 'helm-c-moccur-occur-by-moccur)
    (global-set-key (kbd "C-M-o") 'helm-c-moccur-dmoccur)
    (add-hook 'dired-mode-hook
              '(lambda ()
                 (local-set-key (kbd "O") 'helm-c-moccur-dired-do-moccur-by-moccur)))
    (global-set-key (kbd "C-M-s") 'helm-c-moccur-isearch-forward)
    (global-set-key (kbd "C-M-r") 'helm-c-moccur-isearch-backward)
    )

  ;; helm-ls-git
  (require 'helm-gist nil t)
  (when (require 'helm-ls-git nil t)
    (global-set-key (kbd "C-x C-g") 'helm-ls-git-ls)
    )

  ;; helm-c-yasnippet
  (when (require 'helm-c-yasnippet)
    (setq helm-c-yas-space-match-any-greedy t) ;; [default: nil]
    (global-set-key (kbd "C-c y") 'helm-c-yas-complete)
    )

  ;; helm-ls-git
  (require 'helm-gist nil t)
  (when (require 'helm-ls-git nil t)
    (global-set-key (kbd "C-x C-g") 'helm-ls-git-ls)
    )

  ;; helm-gtags
  (when (require 'helm-gtags nil t)
    (add-hook 'helm-gtags-mode-hook
              '(lambda ()
                 (local-set-key (kbd "M-t") 'helm-gtags-find-tag)
                 (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)
                 (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
                 (local-set-key (kbd "C-t") 'helm-gtags-pop-stack)
                 (local-set-key (kbd "C-c C-f") 'helm-gtags-find-files)))
    )

  ;; ;; helm-migemo
  ;; (when (require 'helm-migemo nil t)
  ;;   (setq helm-use-migemo t)
  ;;   )

  ;; ;; helm-project
  ;; (when  (require 'helm-project nil t)
  ;;    (global-set-key (kbd "C-c C-f") 'helm-project))

  )

