;;; golang.el --- Go language support -*- lexical-binding: t; -*-
;;; Commentary:
;; Go's a tricky one
;;; Code:
(use-package go-mode
  :hook ((go-mode . (lambda ()
                      (add-hook 'before-save-hook #'lsp-format-buffer t t)
                      (add-hook 'before-save-hook #'lsp-organize-imports t t)
                      (setq truncate-lines t
                            indent-tabs-mode t
                            tab-width 4)))
         (go-mode . lsp)))
;;; golang.el ends here
