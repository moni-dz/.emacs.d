;;; org.el --- how to be organized 101 -*- lexical-binding: t; -*-
;;; Commentary:
;; some `org-mode' plugins boys
;;; Code:
(use-package mixed-pitch :hook (text-mode . mixed-pitch-mode))

(use-package org-superstar
  :hook (org-mode . org-superstar-mode)
  :config (org-superstar-configure-like-org-bullets))

(use-package toc-org :hook (org-mode . toc-org-mode))
;;; org.el ends here
