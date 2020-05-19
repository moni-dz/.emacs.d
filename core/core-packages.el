;;; core-packages.el --- Initializes the package manager powered by straight.el -*- lexical-binding: t; -*-
;;; Commentary:
;; Package management powered by `use-package' and `straight'
;;; Code:
(setq package-enable-at-startup nil
      straight-repository-branch "develop"
      straight-use-package-by-default t)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

(use-package no-littering :init (require 'no-littering))

(provide 'core-packages)
;;; core-packages.el ends here
