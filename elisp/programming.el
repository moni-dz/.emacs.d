;;; -*- lexical-binding: t -*-

(elpaca-leaf direnv :config (direnv-mode))

(elpaca-leaf corfu
  :after orderless
  :config (global-corfu-mode)
  :custom
  (corfu-auto . t)
  (corfu-cycle . t))

(leaf emacs
  :config
  (setq completion-cycle-threshold 3
        tab-always-indent 'complete))

(elpaca-leaf yasnippet
  :require t
  :config (yas-global-mode 1))

(elpaca-leaf cape)

(elpaca-leaf orderless
  :config
  (setq completion-styles '(orderless partial-completion basic)
        completion-category-defaults nil
        completion-category-overrides nil))

(elpaca-leaf (eglot :host github :repo "joaotavora/eglot")
  :config (advice-add 'eglot-completion-at-point :around #'cape-wrap-buster))

(require 'elisp-lang)
(require 'org-lang)
(require 'zig-lang)
(require 'r-lang)
(require 'nix-lang)
(require 'rust-lang)

(provide 'programming)
