;;; -*- lexical-binding: t; -*-

(elpaca-leaf rust-mode
  :hook (rust-mode-hook . tree-sitter-hl-mode))

(provide 'rust-lang)
