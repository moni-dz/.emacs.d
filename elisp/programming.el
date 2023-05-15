;;; -*- lexical-binding: t -*-

(elpaca-leaf direnv :config (direnv-mode))

(elpaca-leaf (corfu :files (:defaults "extensions/*"))
  :after (vertico orderless)
  :hook (corfu-mode-hook . corfu-popupinfo-mode)
  :config (global-corfu-mode)
  :custom
  (corfu-auto . t)
  (corfu-cycle . t))

(defun corfu-enable-always-in-minibuffer ()
  "Enable Corfu in the minibuffer if Vertico or MCT are not active."
  (unless (or (bound-and-true-p mct--active)
              (bound-and-true-p vertico--input)
              (eq (current-local-map) read-passwd-map))
    (setq-local corfu-auto t
                corfu-echo-delay nil
                corfu-popupinfo-delay nil)
    (corfu-mode +1)))

(add-hook 'minibuffer-setup-hook #'corfu-enable-always-in-minibuffer)

(elpaca-leaf kind-icon
  :after corfu
  :config (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter)
  :custom (kind-icon-default-face .  'corfu-default))

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
