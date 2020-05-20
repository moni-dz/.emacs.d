;;; wakatime.el --- track time spend programming -*- lexical-binding: t; -*-
;;; Configuration:
;; ahh wakatime
;;; Code:
(use-package wakatime-mode
  :custom (wakatime-cli-path (executable-find "wakatime"))
  :config (global-wakatime-mode 1))
;;; wakatime.el ends here
