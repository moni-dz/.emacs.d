;; -*- lexical-binding: t -*-

(elpaca-leaf direnv :config (direnv-mode))

(elpaca-leaf (corfu :files (:defaults "extensions/*"))
  :hook (corfu-mode-hook . corfu-popupinfo-mode)
  :init  
  (defun corfu-enable-in-minibuffer ()
    "Enable Corfu in the minibuffer if `completion-at-point' is bound."
    (when (where-is-internal #'completion-at-point (list (current-local-map)))
      ;; (setq-local corfu-auto nil) ;; Enable/disable auto completion
      (setq-local corfu-echo-delay nil ;; Disable automatic echo and popup
                  corfu-popupinfo-delay nil)
      (corfu-mode 1)))
  
  (add-hook 'minibuffer-setup-hook #'corfu-enable-in-minibuffer)
  :custom
  (corfu-auto . t)
  (corfu-cycle . t)
  (corfu-popupinfo-delay . '(1.0 . 0.5)))

(elpaca-leaf kind-icon
  :after corfu
  :config (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter)
  :custom (kind-icon-default-face . 'corfu-default))

(elpaca-leaf tree-sitter
  :require t
  :custom-face
  (tree-sitter-hl-face:punctuation . '((t (:family "Comic Code Ligatures")))))

(elpaca-leaf tree-sitter-langs
  :after tree-sitter
  :require t
  :hook (window-setup-hook . global-tree-sitter-mode))

(leaf emacs
  :config
  (setq completion-cycle-threshold 3
        tab-always-indent 'complete)
  :custom-face
  (font-lock-doc-face . '((t (:family "Comic Neue" :height 1.2))))
  (font-lock-doc-markup-face . '((t (:family "Comic Neue" :height 1.2)))))

(elpaca-leaf yasnippet
  :require t
  :config (yas-global-mode 1))

(elpaca-leaf cape)

(elpaca-leaf orderless
  :config
  (setq completion-styles '(orderless partial-completion basic)
        completion-category-defaults nil
        completion-category-overrides nil))

;; WTF he did NOT just use lsp-bridge
(elpaca-leaf (lsp-bridge
              :host github
              :repo "manateelazycat/lsp-bridge"
              :files (:defaults "lsp_bridge.py" "acm/*" "core/*" "langserver/*" "multiserver/*" "resources/*"))
  :require t
  :hook (window-setup-hook . global-lsp-bridge-mode)
  :custom
  (lsp-bridge-enable-hover-diagnostic . t)
  (lsp-bridge-signature-show-function . 'lsp-bridge-signature-show-with-frame)
  (acm-enable-icon . t)  
  :custom-face
  (lsp-bridge-alive-mode-line . '((t (:inherit doom-modeline-lsp-running :family "Comic Neue" :height 1.2))))
  (lsp-bridge-kill-mode-line . '((t (:inherit doom-modeline-lsp-error :family "Comic Neue" :height 1.2)))))

(elpaca-leaf focus)
(elpaca-leaf string-inflection)

(require 'elisp-lang)
(require 'markup-langs)
(require 'zig-lang)
(require 'r-lang)
(require 'nix-lang)
(require 'rust-lang)
(require 'beam-langs)

(provide 'programming)
