;;; -*- lexical-binding: t; -*-

(elpaca-leaf rust-mode
  :hook (rust-mode-hook . eglot-ensure))

(provide 'rust-lang)
