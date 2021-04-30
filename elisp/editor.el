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

(add-hook 'emacs-startup-hook
          #'(lambda ()
              (global-auto-revert-mode +1)
              (show-paren-mode +1)))

(use-package super-save
  :hook
  (emacs-startup . (lambda () (super-save-mode +1)))
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
  (emacs-startup . (lambda () (evil-mode +1))))

(use-package ctrlf
  :hook
  (emacs-startup . (lambda () (ctrlf-mode +1))))

(provide 'editor)
