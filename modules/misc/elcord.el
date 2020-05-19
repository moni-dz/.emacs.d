;;; elcord.el --- Discord Rich Presence -*- lexical-binding: t; -*-
;;; Commentary:
;; Flex on those Discord boys what editor you are using with `elcord'
;;; Code:
(use-package elcord
  :hook (emacs-startup . elcord-mode)
  :custom (elcord-use-major-mode-as-main-icon t))
;;; elcord.el ends here
