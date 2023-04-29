;;; -*- lexical-binding: t -*-

(elpaca-leaf org-modern
  :after org
  :hook (org-mode-hook . org-modern-mode))

(elpaca-leaf (org :repo "https://git.savannah.gnu.org/git/emacs/org-mode.git")
  :custom-face
  (org-document-title . '((t (:inherit outline-1 :height 3.0))))
  (org-document-info . '((t (:inherit outline-3 :height 1.5))))
  (org-level-1 . '((t (:inherit outline-1 :height 2.0))))
  (org-level-2 . '((t (:inherit outline-2 :height 1.8))))
  (org-level-3 . '((t (:inherit outline-3 :height 1.4))))
  (org-level-4 . '((t (:inherit outline-4 :height 1.2))))
  (org-level-5 . '((t (:inherit outline-5 :height 1.0)))))

(elpaca-leaf mixed-pitch :hook (org-mode-hook . mixed-pitch-mode))

(elpaca-leaf toc-org
  :after org
  :hook (org-mode-hook . toc-org-mode))

(provide 'org-lang)
