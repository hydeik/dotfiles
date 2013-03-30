;;; -*- mode: emacs-lisp; coding: utf-8-unix -*-;;
;;;
;;; File: ~/.emacs.d/conf/30_viewer.el
;;; Description: Customize view, viewer
;;;

(require 'view)
;; 読み込み専用ファイルを view-mode で開く
(setq view-read-only t)
;; less 感覚の操作
(define-key view-mode-map (kbd "f") 'View-scroll-page-forward)
(define-key view-mode-map (kbd "b") 'View-scroll-page-backward)
(define-key view-mode-map (kbd "n") 'View-search-last-regexp-forward)
(define-key view-mode-map (kbd "N") 'View-search-last-regexp-backward)
(define-key view-mode-map (kbd "?") 'View-search-regexp-backward)
(define-key view-mode-map (kbd "G") 'View-goto-line-last)
;; vi/w3m 感覚の操作
(define-key view-mode-map (kbd "h") 'backward-char)
(define-key view-mode-map (kbd "j") 'next-line)
(define-key view-mode-map (kbd "k") 'previous-line)
(define-key view-mode-map (kbd "l") 'forward-char)
(define-key view-mode-map (kbd "J") 'View-scroll-line-forward)
(define-key view-mode-map (kbd "K") 'View-scroll-line-backward)

;; install external packages
(el-get 'sync '(bm viewer))

;; bm.el の設定
(when (require 'bm nil t)
  (define-key view-mode-map (kbd "m") 'bm-toggle)
  (define-key view-mode-map (kbd "[") 'bm-previous)
  (define-key view-mode-map (kbd "]") 'bm-next))

;; Viewer
(when (require 'viewer nil t)
  ;; 書き込み不能なファイルでは view-mode から抜けない
  (viewer-stay-in-setup)

  ;; view-mode 時に modeline に色を付ける
  (setq viewer-modeline-color-unwritable "tomato3")
  (setq viewer-modeline-color-view "red4")
  (viewer-change-modeline-color-setup)
  )
