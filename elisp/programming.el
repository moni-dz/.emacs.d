(use-package flycheck
  :hook
  ((prog-mode . (lambda () (flycheck-mode +1)))
   ;; Emacs Lisp syntax checking has a bunch of false positives, best to disable it
   (emacs-lisp-mode . (lambda () (flycheck-mode -1)))))

(use-package company
  :hook
  (prog-mode . company-mode)
  :custom
  (company-idle-delay 0.5)
  (company-tooltip-limit 14)
  (company-tooltip-align-annotatons t)
  (company-minimum-prefix-length 1)
  (company-selection-wrap-around t)
  (company-backends '(company-capf))
  (company-dabbrev-other-buffers nil)
  (company-dabbrev-ignore-case nil)
  (company-dabbrev-downcase nil))

(use-package lsp-mode
  :hook
  (lsp-mode . lsp-enable-which-key-integration)
  :custom
  (lsp-auto-configure t)
  (lsp-enable-yasnippet nil)
  (lsp-diagnostic-package :flycheck)
  :commands lsp)

(use-package lsp-ui
  :after lsp
  :hook
  (lsp . lsp-ui-mode)
  :commands lsp-ui-mode
  :custom
  (lsp-ui-sideline-show-code-actions t)
  (lsp-ui-sideline-delay 0.3)
  (lsp-ui-sideline-actions-icon nil)
  (lsp-ui-doc-enable)
  (lsp-ui-doc-position 'top))

(use-package lsp-ivy
  :after lsp
  :defer t
  :commands lsp-ivy-workspace-symbol)

(require 'nix-lang)
(require 'org-lang)

(provide 'programming)
