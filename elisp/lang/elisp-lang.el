;;; -*- lexical-binding: t -*-

;; ELisp/l looks odd
(add-hook
 'emacs-lisp-mode-hook
 (lambda () (setq mode-name "Emacs Lisp")))

(use-package highlight-defined
  :hook
  (emacs-lisp-mode . highlight-defined-mode))

(use-package aggressive-indent
  :hook
  (emacs-lisp-mode . aggressive-indent-mode))

(provide 'elisp-lang)
