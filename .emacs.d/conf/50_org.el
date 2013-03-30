;;; -*- mode: emacs-lisp; coding: utf-8-unix; indent-tabs-mode: nil; -*-
;;;
;;; File: ~/.emacs.d/conf/50_org.el
;;; Description: Customize Org mode
;;;

(when (require 'org-install nil t)
  (require 'org)
  (add-to-list 'auto-mode-alist  '("\\.org$" . org-mode))

  ;; keybindings
  (global-set-key "\C-cl" 'org-store-link)
  (global-set-key "\C-cc" 'org-capture)
  (global-set-key "\C-ca" 'org-agenda)
  (global-set-key "\C-cb" 'org-iswitchb)

  ;; Default directory for Org files
  (setq org-directory "~/Dropbox/org")

  ;; Task (TODO) list
  ;; "C-c C-t" -> org-todo
  (setq org-use-fast-todo-selection t)
  (setq org-todo-keywords
        ;; TASK    -- TODO (Project単位)
        ;; STARTED -- 今行動している状態
        ;; WAITING -- 他人からの応答待ち，行動できる状態まで待機
        ;; DONE    -- 完了
        ;; SOMEDAY -- いつかやる
        ;; CANCEL  -- 取りやめた状態
        '((sequence "TASK(t)" "STARTED(s)"  "WAITING(w@/!)"
                    "|" "DONE(x!)" "SOMEDAY(s!)" "CANCEL(c@/!)")
          (sequence "APPT(a)" "|" "DONE(x)" "CANCEL(c@/!)")
          (sequence "NEXT(n)" "|" "DONE(x!)")))
  ;; Task 完了時の時刻を記録
  (setq org-log-done 'time)

  ;; org-capture
  (setq org-capture-templates
        '(
          ;; TODO list
          ("t" "TODO" entry (file+headline "~/Dropbox/org/todo.org" "Tasks")
           "* TASK %?n %in %a")
          ;; Shopping
          ("s" "Shopping" entry (file+headline "~/Dropbox/org/todo.org" "Shopping")
           "* TASK %?n %in %a")
          ;; Memo, Bookmarks, records
          ("j" "Journal" entry (file+datetree "~/Dropbox/org/journal.org")
           "* %?n %Un %in %a")
          ;; Research note
          ("n" "Note" entry (file+headline "~/Dropbox/org/notes.org" "Notes")
           "* %?n %Un %i")
          ;; Literature in BiBTeX
          ("a" "Article" entry (file+headline "~/Dropbox/org/reading.org" "Articles")
           "* %An Ref. on %Un %:author [%:year]: %:titlen
                                   In %:journal, pp. %:pages.n Comment: %?")
          ("b" "Book" entry (file+headline "~/Dropbox/org/reading.org" "Books")
           "* %An Ref. on %Un %:author [%:year]: %:titlen Comment: %?")
          ))

  ;; Agenda
  (setq org-agenda-files (list (concat org-directory "/todo.org")
                               (concat org-directory "/birthday.org")))

  )

