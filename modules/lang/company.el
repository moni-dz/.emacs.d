;;; company.el --- Auto completion backend -*- lexical-binding: t; -*-
;;; Commentary:
;; Company as a completion backend
;;; Code:
(use-package company
  :hook (prog-mode . company-mode)
  :custom
  (company-idle-delay 0)
  (company-tooltip-limit 14)
  (company-tooltip-align-annotatons t)
  (company-minimum-prefix-length 1)
  (company-selection-wrap-around t)
  (company-backends '(company-capf))
  (company-dabbrev-other-buffers nil)
  (company-dabbrev-ignore-case nil)
  (company-dabbrev-downcase nil))

(use-package company-prescient
  :if (feature-p! +prescient)
  :hook (company-mode . company-prescient-mode)
  :custom (prescient-save-file (concat f2k-dir "cache/prescient-save.el"))
  :config (prescient-persist-mode 1))

(use-package company-box
  :if (feature-p! +childframe)
  :hook (company-mode . company-box-mode)
  :custom
  (company-box-show-single-candidate t)
  (company-box-max-candidates 50))
;;; company.el ends here
