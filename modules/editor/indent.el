;;; indent.el --- Aggressive indents -*- lexical-binding: t; -*-
;;; Commentary:
;; Use aggressive-indent and for the love of God use spaces as default indentation
;;; Code:
(setq-default indent-tabs-mode nil
              tab-width 2)

(use-package aggressive-indent :hook (prog-mode . aggressive-indent-mode))
;;; indent.el ends here
