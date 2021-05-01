;;; -*- lexical-binding: t -*-

(pkg! rustic
  :mode
  ("\\.rs\\'" . rustic-mode)
  :custom
  (rustic-lsp-client 'eglot))

(provide 'rust-lang)
