(prefer-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq buffer-file-coding-system 'utf-8
      save-buffer-coding-system 'utf-8)

(setq-default require-final-newline t
	      indent-tabs-mode nil
              tab-width 2)

(use-package aggressive-indent
  :hook (prog-mode . aggressive-indent-mode))

(use-package hungry-delete
  :hook (prog-mode . global-hungry-delete-mode))

(use-package elec-pair
  :hook (prog-mode . electric-pair-mode))

(show-paren-mode t)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package evil
  :config (evil-mode +1))

(provide 'editor)
