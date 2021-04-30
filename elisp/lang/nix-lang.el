;;; -*- lexical-binding: t -*-

(pkg! nix-mode
  :mode "\\.nix\\'"
  :hook
  (nix-mode . eglot-ensure))

(provide 'nix-lang)
