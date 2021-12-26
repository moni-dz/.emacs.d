;;; -*- lexical-binding: t -*-

(pkg! nix-mode
  :mode "\\.nix\\'"
  :hook
  (nix-mode . lsp-deferred))

(provide 'nix-lang)
