;;; -*- lexical-binding: t -*-

(prefer-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)

(setq-default buffer-file-coding-system 'utf-8
              save-buffer-coding-system 'utf-8
              auto-save-default nil
              scroll-step 1
              scroll-conservatively 10000
              auto-window-vscroll nil
              require-final-newline t
              indent-tabs-mode nil
              tab-width 2)

(add-hook 'emacs-startup-hook #'global-visual-line-mode)

(pkg! unicode-fonts
  :hook
  (emacs-startup . unicode-fonts-setup))

(pkg! format-all
  :commands format-all-buffer
  :hook
  (prog-mode . format-all-ensure-formatter))

(pkg! paren
  :hook
  (prog-mode . show-paren-mode))

(pkg! hl-line
  :hook
  ((prog-mode org-mode text-mode conf-mode) . hl-line-mode))

(pkg! autorevert
  :hook
  (emacs-startup . global-auto-revert-mode))

(pkg! super-save
  :hook
  (emacs-startup . super-save-mode)
  :custom
  (super-save-auto-save-when-idle t))

(pkg! beacon
  :hook
  (focus-in . beacon-blink)
  :config
  (beacon-mode))

(pkg! smartparens
  :config
  (require 'smartparens-config)
  :hook
  (prog-mode . smartparens-mode))

(pkg! hl-todo
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

(pkg! highlight-indent-guides
  :hook
  (prog-mode . highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-method 'character))

(defun kill-other-buffers ()
  "Kill all other buffers"
  (interactive)
  (mapc 'kill-buffer
        (delq (current-buffer)
              (remove-if-not 'buffer-file-name (buffer-list)))))

(global-set-key (kbd "C-c k") #'kill-other-buffers)
(global-set-key (kbd "C-c C-k") #'kill-buffer-and-window)

(setq god-mode-enable-function-key-translation nil)

(pkg! god-mode
  :hook
  ((emacs-startup . god-mode)
   (god-mode-enabled . (lambda () (setq cursor-type 'box)))
   (god-mode-disabled . (lambda () (setq cursor-type 'bar))))
  :bind
  (("<escape>" . god-mode-all)
   (:map god-local-mode-map ("i" . god-local-mode)))
  :custom
  (god-exempt-major-modes nil)
  (god-exempt-predicates nil))

(pkg! ctrlf
  :hook
  (emacs-startup . ctrlf-mode))

(provide 'editor)
