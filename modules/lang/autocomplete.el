;;; autocomplete.el --- Auto completion backend -*- lexical-binding: t; -*-
;;; Commentary:
;; Company as a completion backend
;;; Code:
(use-package company
  :hook (prog-mode . company-mode)
  :custom
  (company-idle-delay 0.2)
  (company-minimum-prefix-length 1))

(use-package company-box
  :if (feature-p! +childframe)
  :hook (company-mode . company-box-mode))
;;; autocompletion.el ends here
