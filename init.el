;;; init.el --- The latest init file to load -*- lexical-binding: t; -*-
;;; Commentary:
;; We define where everything goes and load the core.
;;; Code:
(setq-default use-dialog-box nil)
(tooltip-mode -1) ;; no u tooltip

(defalias 'yes-or-no-p 'y-or-n-p)

(defvar f2k-dir user-emacs-directory)
(defvar f2k-core-dir (expand-file-name "core" f2k-dir))
(defvar f2k-modules-dir (expand-file-name  "modules" f2k-dir))

(add-to-list 'load-path f2k-core-dir)

(setq custom-file (if (memq system-type '(gnu/linux darwin)) "/dev/null" "NUL"))

(require 'core)

(load (expand-file-name "modules" f2k-dir))
(load (expand-file-name "config" f2k-dir))
;;; init.el ends here
