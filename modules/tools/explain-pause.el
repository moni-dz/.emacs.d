;;; explain-pause.el --- why is Emacs slow? -*- lexical-binding: t; -*-
;;; Commentary:
;; im testing this
;;; Code:
(use-package explain-pause-mode
  :straight (explain-pause-mode :type git :host github :repo "lastquestion/explain-pause-mode")
  :init (explain-pause-mode 1))
;;; explain-pause.el ends here
