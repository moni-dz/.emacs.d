;;; elcord.el --- Discord Rich Presence -*- lexical-binding: t; -*-
;;; Commentary:
;; Flex on those Discord boys what editor you are using with `elcord'
;;; Code:
(use-package elcord
  :init (elcord-mode)
  :custom
  (elcord-refresh-rate 2)
  (elcord-use-major-mode-as-main-icon t))
;;; elcord.el ends here
