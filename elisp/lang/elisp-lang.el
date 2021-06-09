;;; -*- lexical-binding: t -*-

;; ELisp/l looks odd
(add-hook
 'emacs-lisp-mode-hook
 (lambda () (setq mode-name "Emacs Lisp")))

(pkg! highlight-defined
  :hook
  (emacs-lisp-mode . highlight-defined-mode))

(pkg! paredit
  :hook
  (emacs-lisp-mode . enable-paredit-mode))

(pkg! aggressive-indent
  :hook
  (emacs-lisp-mode . aggressive-indent-mode))

(provide 'elisp-lang)
