;;; -*- mode: emacs-lisp; coding: utf-8-unix; indent-tabs-mode: nil; -*-
;;;
;;; File: ~/.emacs.d/conf/50_auctex.el
;;; Description: Customize AUCTeX mode
;;;


(when (load "auctex.el" nil t t)
  (load "preview-latex.el" nil t t)

  (setq TeX-default-mode 'japanese-latex-mode)
  (setq japanese-LaTeX-default-style "jsarticle")
  (setq TeX-engine-alist '((ptex "pTeX" "eptex" "platex" "eptex")
                           (jtex "jTeX" "jtex" "jlatex" nil)
                           (uptex "upTeX" "euptex" "uplatex" "euptex")))
  (setq TeX-engine 'eptex)

  (setq TeX-view-program-list '(("Mxdvi" "open -a Mxdvi.app %d")
                                ("TeXShop" "open -a TeXShop.app %o")
                                ("open" "open %o")
                                ))
  (setq TeX-view-program-selection '((output-dvi "Mxdvi")
                                     (output-pdf "TeXShop")
                                     (output-html "open")))
  (setq preview-image-type 'dvipng)
  (setq TeX-source-correlate-method 'synctex)
  (setq TeX-source-correlate-start-server t)
  (add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
  (add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  (add-hook 'LaTeX-mode-hook
            (function
             (lambda ()
               (add-to-list 'TeX-command-list
                            '("Latexmk" "/usr/texbin/latexmk %t"
                              TeX-run-TeX nil (latex-mode) :help "Run Latexmk"))
               ;; (add-to-list 'TeX-command-list
               ;;               '("pdfpLaTeX" "/usr/texbin/platex %S %(mode) %t && /usr/texbin/dvipdfmx %d"
               ;;                 TeX-run-TeX nil (latex-mode) :help "Run pLaTeX and dvipdfmx"))
               (add-to-list 'TeX-command-list
                            '("pLaTeX2pdf" "~/Library/TeXShop/bin/platex2pdf-utf8 %t"
                              TeX-run-TeX nil (latex-mode) :help "Run epTeX and dvipdfmx"))
               (add-to-list 'TeX-command-list
                            '("pdfpLaTeX2" "~/Library/TeXShop/bin/pdfplatex %t"
                              TeX-run-TeX nil (latex-mode) :help "Run pLaTeX, dvips, and ps2pdf"))
               (add-to-list 'TeX-command-list
                            '("pdfupLaTeX" "~/Library/TeXShop/bin/pdfuplatex %t"
                              TeX-run-TeX nil (latex-mode) :help "Run upLaTeX and dvipdfmx"))
               (add-to-list 'TeX-command-list
                            '("pdfupLaTeX2" "~/Library/TeXShop/bin/pdfuplatex2 %t"
                              TeX-run-TeX nil (latex-mode) :help "Run upLaTeX, dvips, and ps2pdf"))
               (add-to-list 'TeX-command-list
                            '("pBibTeX" "/usr/texbin/pbibtex %s"
                              TeX-run-BibTeX nil t :help "Run pBibTeX"))
               (add-to-list 'TeX-command-list
                            '("upBibTeX" "/usr/texbin/upbibtex %s"
                              TeX-run-BibTeX nil t :help "Run upBibTeX"))
               (add-to-list 'TeX-command-list
                            '("BibTeXu" "/usr/texbin/bibtexu %s"
                              TeX-run-BibTeX nil t :help "Run BibTeXu"))
               (add-to-list 'TeX-command-list
                            '("Mendex" "/usr/texbin/mendex %s"
                              TeX-run-command nil t :help "Create index file with mendex"))
               (add-to-list 'TeX-command-list
                            '("Preview" "/usr/bin/open -a Preview.app %s.pdf"
                              TeX-run-discard-or-function t t :help "Run Preview"))
               (add-to-list 'TeX-command-list
                            '("TeXShop" "/usr/bin/open -a TeXShop.app %s.pdf"
                              TeX-run-discard-or-function t t :help "Run TeXShop"))
               (add-to-list 'TeX-command-list
                            '("TeXworks" "/usr/bin/open -a TeXworks.app %s.pdf"
                              TeX-run-discard-or-function t t :help "Run TeXworks"))
               )))
  ;;
  ;; RefTeX with AUCTeX
  ;;
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (setq reftex-plug-into-AUCTeX t)

  ;;
  ;; kinsoku.el
  ;;
  (setq kinsoku-limit 10)
  )
