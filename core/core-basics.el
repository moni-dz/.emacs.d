;;; core-basics.el --- The basic configuration -*- lexical-binding: t -*-
;;; Commentary:
;; Contains basic configuration
;;; Code:

(when (display-graphic-p)
  (menu-bar-mode 0)
  (toggle-scroll-bar 0)
  (tool-bar-mode 0))

;; No backup
(setq make-backup-files nil)

;; Encoding
(prefer-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq buffer-file-coding-system 'utf-8
      save-buffer-coding-system 'utf-8)

;; Confirmation messages disabled if possible
(setq confirm-kill-emacs nil)
(when (> emacs-major-version 25)
  (setq confirm-kill-processes nil))

;; Better scrolling
(setq mouse-wheel-progressive-speed nil
      scroll-conservatively 10000
      scroll-margin 0
      scroll-preserve-screen-position t)

;; Disable bells
(setq ring-bell-function 'ignore
      visible-bell nil)

;; Buffer names uniquifying
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; Startup screens and scratch buffer
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(setq initial-scratch-message nil)

;; End file with \n
(setq-default require-final-newline t)

;; No lockfiles
(setq create-lockfiles nil)

(setq inhibit-compacting-font-caches nil) ;; Don't compact font caches to help with `org-superstar' performance
(setq bidi-display-reordering nil)
(setq cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)
(setq frame-inhibit-implied-resize t)

(provide 'core-basics)
;;; core-basics.el ends here
