;;; -*- lexical-binding: t -*-

(pkg! flycheck
  :hook
  ((prog-mode . flycheck-mode)
   ;; Emacs Lisp syntax checking has a bunch of false positives, best to disable it
   (emacs-lisp-mode . (lambda () (flycheck-mode -1)))))

(pkg! company
  :hook
  (prog-mode . company-mode)
  :custom
  (company-idle-delay 0.2)
  (company-tooltip-limit 14)
  (company-tooltip-align-annotations t)
  (company-minimum-prefix-length 1)
  (company-selection-wrap-around t)
  (company-backends '(company-capf))
  (company-format-margin-function nil))

(pkg! eglot
  :hook
  (eglot--managed-mode . (lambda () (flymake-mode -1))))

(require 'c-cxx-lang)
(require 'nix-lang)
(require 'org-lang)
(require 'rust-lang)
(require 'elisp-lang)

(provide 'programming)
