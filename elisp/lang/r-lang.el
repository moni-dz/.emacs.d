;;; -*- lexical-binding: t; -*-

(elpaca-leaf ess
  :hook (ess-mode-hook . lsp-deferred))

(elpaca-leaf poly-R
  :init
  (setq polymode-lsp-integration nil))

(provide 'r-lang)
