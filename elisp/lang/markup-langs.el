;;; -*- lexical-binding: t -*-

(elpaca-leaf org-modern
  :after org
  :hook (org-mode-hook . org-modern-mode)
  :custom-face
  (org-modern-symbol . '((t (:family "DejaVu Sans Mono" :height 1.6)))))

(elpaca-leaf org-present
  :after org
  :init  
  (defun org/start-presentation ()
    (zen-mode +1)
    (fontaine-set-preset 'presentation)
    (org-display-inline-images)
    (org-present-hide-cursor)
    (org-present-read-only))

  (defun org/end-presentation ()
    (zen-mode -1)
    (fontaine-set-preset 'regular)
    (org-remove-inline-images)
    (org-present-show-cursor)
    (org-present-read-write))
  :hook ((org-present-mode-hook . org/start-presentation)
         (org-present-mode-quit-hook . org/end-presentation)))

(elpaca-leaf (org :repo "https://git.savannah.gnu.org/git/emacs/org-mode.git")
  :hook (org-mode-hook . (lambda () (show-paren-mode -1)))
  :custom-face
  (org-document-title . '((t (:inherit outline-1 :height 2.5))))
  (org-document-info . '((t (:inherit outline-3 :height 1.5))))
  (org-default . '((t (:height 1.1))))
  (org-level-1 . '((t (:inherit outline-1 :height 1.8))))
  (org-level-2 . '((t (:inherit outline-2 :height 1.6))))
  (org-level-3 . '((t (:inherit outline-3 :height 1.4))))
  (org-level-4 . '((t (:inherit outline-4 :height 1.2))))
  (org-level-5 . '((t (:inherit outline-5 :height 1.0)))))

(elpaca-leaf mixed-pitch
  :hook ((org-mode-hook markdown-mode-hook) . mixed-pitch-mode)
  :custom (mixed-pitch-set-height . t))

(elpaca-leaf (markdown-mode :host github :repo "jrblevin/markdown-mode")
  :custom
  (markdown-fontify-code-block-natively . t)
  (markdown-code-lang-modes . '(("elisp" . emacs-lisp-mode)
                                ("ditaa" . artist-mode)
                                ("dot" . fundamental-mode)
                                ("sqlite" . sql-mode)
                                ("calc" . fundamental-mode)
                                ("C" . c-mode)
                                ("cpp" . c++-mode)
                                ("C++" . c++-mode)
                                ("screen" . shell-script-mode)
                                ("shell" . sh-mode)
                                ("bash" . sh-mode)
                                ("rust" . rust-mode))))

(elpaca-leaf toc-org
  :after org
  :hook (org-mode-hook . toc-org-mode))

(provide 'markup-langs)
