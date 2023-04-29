;;; -*- lexical-binding: t -*-

(elpaca-leaf highlight-quoted
  :hook (emacs-lisp-mode-hook . highlight-quoted-mode))

(elpaca-leaf highlight-defined
  :hook (emacs-lisp-mode-hook . highlight-defined-mode))

(elpaca-leaf elisp-def
  :hook ((emacs-lisp-mode-hook ielm-mode-hook) . elisp-def-mode))

(elpaca-leaf lisp-butt-mode
  :hook (emacs-lisp-mode-hook . lisp-butt-mode))

(elpaca-leaf aggressive-indent
  :hook (emacs-lisp-mode-hook . aggressive-indent-mode))

(provide 'elisp-lang)
