;;; -*- mode: emacs-lisp; coding: utf-8-unix -*-;;
;;;
;;; File: ~/.emacs.d/init.el
;;; Description: Setup file for GNU Emacs.
;;;

;; Start Emacs server
(server-start)

;; Set load-path
(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp/"))

;; exec-path
;; (add-to-list 'exec-path (expand-file-name "~/.emacs.d/bin/"))
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "/usr/texbin")

;;;
;;; el-get -- install and manage elisp code for Emacs
;;;   <https://github.com/dimitri/el-get>
;;;

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
;; Use master branch (developper edition of el-get)
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))
;; Local folder for my own recipes
(add-to-list 'el-get-recipe-path "~/.emacs.d/local/el-get/recipes")

;;;
;;; init-loader -- split Emacs init file
;;; <https://gist.github.com/1021706>
;;;
(el-get 'sync '(init-loader))
(require 'init-loader)
;; init-loader-directory [default "~/.emacs.d/inits"]
(setq init-loader-directory "~/.emacs.d/conf") 
(init-loader-load init-loader-directory)
