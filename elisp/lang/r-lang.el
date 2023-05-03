;;; -*- lexical-binding: t; -*-

(elpaca-leaf ess
  :hook (ess-r-mode-hook . eglot-ensure))

(elpaca-leaf poly-R
  :init
  (setq polymode-lsp-integration nil))

(provide 'r-lang)
