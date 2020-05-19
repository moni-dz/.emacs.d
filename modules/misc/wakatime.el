;;; wakatime.el --- track time spend programming -*- lexical-binding: t; -*-
;;; Configuration:
;; ahh wakatime
;;; Code:
(use-package wakatime-mode
  :custom (wakatime-cli-path (executable-find "wakatime"))
  :hook (emacs-startup . global-wakatime-mode))
;;; wakatime.el ends here
