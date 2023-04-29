;;; -*- lexical-binding: t -*-

(elpaca-leaf direnv
  :config (direnv-mode))

(elpaca-leaf flycheck
  :hook
  ((prog-mode-hook . flycheck-mode)
   (emacs-lisp-mode-hook . (lambda () (flycheck-mode -1))))
  :custom
  (flycheck-disabled-checkers . '(emacs-lisp-checkdoc)))

(elpaca-leaf flycheck-popup-tip
  :after flycheck
  :hook
  (flycheck-mode-hook . flycheck-popup-tip-mode))

(elpaca-leaf flycheck-posframe
  :after flycheck
  :hook
  (flycheck-mode-hook . flycheck-posframe-mode)
  :config
  (flycheck-posframe-configure-pretty-defaults))

(elpaca-leaf corfu
  :after orderless
  :config
  (global-corfu-mode)
  :custom
  (corfu-auto . t)
  (corfu-cycle . t))
 
(leaf emacs
  :config
  (setq completion-cycle-threshold 3
        tab-always-indent 'complete))

(elpaca-leaf yasnippet
  :require t
  :config
  (yas-global-mode 1))

(elpaca-leaf cape)

(elpaca-leaf orderless
  :config
  (setq completion-styles '(orderless partial-completion basic)
        completion-category-defaults nil
        completion-category-overrides nil))

(elpaca-leaf lsp-mode
  :after orderless cape corfu
  :config
  (defun prog/orderless-dispatch-flex-first (_pattern index _total)
    (and (eq index 0) 'orderless-flex))
  
  (defun prog/lsp-setup-compl ()
    (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults)
                     '(orderless))))

  (add-hook 'orderless-style-dispatchers #'prog/orderless-dispatch-flex-first nil 'local)

  (setq-local completion-at-point-functions (list (cape-capf-buster #'lsp-completion-at-point)))
  :init
  (setq lsp-completion-provider :none
        lsp-headerline-breadcrumb-enable nil
        lsp-modeline-diagnostics-enable nil
        lsp-modeline-code-actions-enable nil)
  :hook
  (lsp-completion-mode-hook . prog/lsp-setup-compl))

(require 'org-lang)
(require 'zig-lang)
(require 'r-lang)

(provide 'programming)
