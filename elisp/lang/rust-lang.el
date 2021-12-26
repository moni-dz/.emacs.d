;;; -*- lexical-binding: t -*-

(pkg! rustic
  :mode
  ("\\.rs\\'" . rustic-mode)
  :hook
  (rustic-mode . eglot-ensure))

(provide 'rust-lang)
