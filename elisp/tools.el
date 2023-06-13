;;; -*- lexical-binding: t -*-

(elpaca-leaf zoxide)

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

(elpaca-leaf keycast)

(provide 'tools)
