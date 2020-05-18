;;; core.el --- The heart of this configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; Load all the core components
;;; Code:
(defvar f2k--core-modules
  '(core-packages
    core-custom
    core-lib
    core-basics
    core-ui))

(dolist (core-module f2k--core-modules)
  (require core-module))

(provide 'core)
;;; core.el ends here
