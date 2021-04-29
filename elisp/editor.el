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
      auto-save-default nil)

(setq-default require-final-newline t
	            indent-tabs-mode nil
              tab-width 2)

(global-auto-revert-mode +1)

(use-package super-save
  :config
  (super-save-mode +1)
  :custom
  (super-save-auto-save-when-idle t))

(use-package smartparens
  :config
  (require 'smartparens-config)
  :hook
  (prog-mode . smartparens-mode))

(show-paren-mode t)

(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package evil
  :config
  (evil-mode +1))

(use-package ctrlf
  :config
  (ctrlf-mode +1))

(provide 'editor)
