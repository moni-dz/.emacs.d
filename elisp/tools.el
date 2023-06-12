;;; -*- lexical-binding: t -*-

;; dired
(elpaca-leaf diredfl
  :hook (dired-mode-hook . diredfl-global-mode)
  :custom-face
  (diredfl-dir-heading . '((t (:inherit variable-pitch :height 2.0)))))

;; git client
(elpaca-leaf magit
  :commands magit
  :custom
  (magit-section-visibility-indicator . nil))

;; Some tricks had to be done in order for this to work with `doom-modeline'
(elpaca-leaf keycast
  :config
  (define-minor-mode keycast-mode
    "Show current command and its keybinding in the modeline."
    :global t
    (if keycast-mode
        (add-hook 'pre-command-hook 'keycast--update t)
      (remove-hook 'pre-command-hook 'keycast--update)))

  (add-to-list 'global-mode-string '("" mode-line-keycast)))

(provide 'tools)
