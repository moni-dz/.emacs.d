;;; -*- lexical-binding: t -*-

(pkg! flycheck
  :hook
  ((prog-mode . flycheck-mode)
   ;; Too much false positives, best to be disabled
   (emacs-lisp-mode . (lambda () (flycheck-mode -1)))))

(pkg! flycheck-popup-tip
  :after flycheck
  :hook
  (flycheck-mode . flycheck-popup-tip-mode))

(pkg! flycheck-posframe
  :after flycheck
  :hook
  (flycheck-mode . flycheck-posframe-mode)
  :config
  (flycheck-posframe-configure-pretty-defaults))

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
  :straight (:type git :host github :repo "joaotavora/eglot")
  :hook
  (eglot--managed-mode . (lambda () (flymake-mode -1)))
  :config
  (add-to-list 'eglot-server-programs '(nim-mode . ("nimlsp"))))

(require 'c-cxx-lang)
(require 'nix-lang)
(require 'org-lang)
(require 'rust-lang)
(require 'elisp-lang)
(require 'nim-lang)

(provide 'programming)
