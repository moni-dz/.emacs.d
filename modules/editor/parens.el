;;; parens.el --- Parentheses, brackets, braces matching -*- lexical-binding: t; -*-
;;; Commentary:
;; Electric indent and rainbow delimiters
;;; Code:
(use-package elec-pair
  :hook (prog-mode . electric-pair-mode))

(show-paren-mode t)

(use-package rainbow-delimiters
  :if (feature-p! +rainbow)
  :hook (prog-mode . rainbow-delimiters-mode))
;;; parens.el ends here
