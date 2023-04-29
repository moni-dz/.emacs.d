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
              tab-width 2
              mac-redisplay-dont-reset-vscroll t
              mac-mouse-wheel-smooth-scroll nil
              ns-use-native-fullscreen nil
              ns-pop-up-frames nil
              ns-command-modifier 'meta)

(add-hook 'emacs-startup-hook #'global-visual-line-mode)

(elpaca-leaf osx-trash
  :if (eq system-type 'darwin)
  :commands osx-trash-move-file-to-trash
  :config
  (setq delete-by-moving-to-trash t)

  (when (not (fboundp 'system-move-file-to-trash))
    (defun system-move-file-to-trash (file)
      "Move FILE to trash."
      (when (and (not (eq system-type 'gnu/linux))
                 (not (file-remote-p default-directory)))
        (osx-trash-move-file-to-trash file)))))

(elpaca-leaf unicode-fonts
  :hook
  (emacs-startup-hook . unicode-fonts-setup))

(elpaca-leaf format-all
  :commands format-all-buffer
  :hook
  (prog-mode-hook . format-all-ensure-formatter))

(add-hook 'prog-mode-hook #'show-paren-mode)

(leaf hl-line
  :hook
  ((prog-mode-hook org-mode-hook text-mode-hook conf-mode-hook) . hl-line-mode))

(leaf autorevert
  :hook
  (emacs-startup-hook . global-auto-revert-mode))

(elpaca-leaf super-save
  :hook
  (emacs-startup-hook . super-save-mode)
  :init
  (setq auto-save-default nil)
  :custom
  (super-save-auto-save-when-idle . t))

(elpaca-leaf smartparens
  :require t
  :hook
  (prog-mode-hook . smartparens-mode))

(elpaca-leaf hl-todo
  :hook (prog-mode-hook . hl-todo-mode)
  :custom
  (hl-todo-highlight-punctuation . ":")
  (hl-todo-keyword-faces .
    `(("TODO" warning bold)
     ("FIXME" error bold)
     ("HACK" font-lock-constant-face bold)
     ("REVIEW" font-lock-keyword-face bold)
     ("NOTE" success bold)
     ("DEPRECATED" font-lock-doc-face bold)
     ("BUG" error bold)
     ("XXX" font-lock-constant-face bold))))

(elpaca-leaf highlight-indent-guides
  :hook
  (prog-mode-hook . highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-method 'character))

(defun kill-other-buffers ()
  "Kill all other buffers"
  (interactive)
  (mapc 'kill-buffer
        (delq (current-buffer)
              (remove-if-not 'buffer-file-name (buffer-list)))))

(global-set-key (kbd "C-c C-k") #'kill-other-buffers)
(global-set-key (kbd "C-c k") #'kill-buffer-and-window)

(elpaca-leaf evil
  :require t
  :config (evil-mode 1))

(elpaca-leaf ctrlf
  :hook
  (emacs-startup-hook . ctrlf-mode))

(provide 'editor)
