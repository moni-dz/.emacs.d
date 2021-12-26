(pkg! nim-mode
  :mode "\\.nim\\'"
  :hook
  (nim-mode . eglot-ensure))

(provide 'nim-lang)
