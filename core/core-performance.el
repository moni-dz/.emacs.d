;;; core-performance.el --- performance tweaks -*- lexical-binding: t; -*-
;;; Commentary:
;; moved this to core from being a module
;;; Code:
(use-package gcmh
  :init (gcmh-mode +1)
  :hook (focus-out-hook . gcmh-idle-garbage-collect)
  :custom
  (gcmh-verbose nil)
  (gcmh-idle-delay 6)
  (gcmh-high-cons-threshold 16777216))

(provide 'core-performance)
;;; core-performance.el ends here
