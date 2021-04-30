;;; -*- lexical-binding: t -*-

(prefer-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)

(setq buffer-file-coding-system 'utf-8
      save-buffer-coding-system 'utf-8
      auto-save-default nil
      scroll-step 1
      scroll-conservatively 10000
      auto-window-vscroll nil)

(setq-default require-final-newline t
	            indent-tabs-mode nil
              tab-width 2)

(when (display-graphic-p)
  (add-hook 'prog-mode-hook #'hl-line-mode)
  (add-hook 'org-mode #'hl-line-mode)
  (add-hook 'text-mode-hook #'hl-line-mode)
  (add-hook 'conf-mode #'hl-line-mode))

(add-hook 'emacs-startup-hook #'global-auto-revert-mode)
(add-hook 'prog-mode-hook #'show-paren-mode)

(use-package super-save
  :hook
  (emacs-startup . super-save-mode)
  :custom
  (super-save-auto-save-when-idle t))

(use-package smartparens
  :config
  (require 'smartparens-config)
  :hook
  (prog-mode . smartparens-mode))

(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package hl-todo
  :hook (prog-mode . hl-todo-mode)
  :custom
  (hl-todo-highlight-punctuation ":")
  (hl-todo-keyword-faces
   `(("TODO" warning bold)
     ("FIXME" error bold)
     ("HACK" font-lock-constant-face bold)
     ("REVIEW" font-lock-keyword-face bold)
     ("NOTE" success bold)
     ("DEPRECATED" font-lock-doc-face bold)
     ("BUG" error bold)
     ("XXX" font-lock-constant-face bold))))

(use-package highlight-indent-guides
  :hook
  (prog-mode . highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-method 'character))

(use-package evil
  :hook
  (emacs-startup . evil-mode))

(use-package ctrlf
  :hook
  (emacs-startup . ctrlf-mode))

(provide 'editor)
