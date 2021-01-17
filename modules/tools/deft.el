;;; deft.el --- notational velocity -*- lexical-binding: t; -*-
;;; Commentary:
;; note taking
;;; Code:
(use-package deft
  :bind ("C-x N" . deft)
  :commands (deft)
  :custom
  (deft-recursive t)
  (deft-extensions '("org"))
  (deft-directory "~/Extras/Notes"))
;;; magit.el ends here
