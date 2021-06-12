;;; -*- lexical-binding: t -*-

;; ELisp/l looks odd
(add-hook
 'emacs-lisp-mode-hook
 (lambda () (setq mode-name "Emacs Lisp")))

(pkg! highlight-defined
  :hook
  (emacs-lisp-mode . highlight-defined-mode))

(pkg! lisp-butt-mode
  :hook
  (emacs-lisp-mode . lisp-butt-mode))

(pkg! parinfer-rust-mode
  :hook emacs-lisp-mode
  :init
  (setq parinfer-rust-auto-download t))

(pkg! aggressive-indent
  :hook
  (emacs-lisp-mode . aggressive-indent-mode))

(provide 'elisp-lang)
