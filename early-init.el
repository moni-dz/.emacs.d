;;; early-init.el --- Package management -*- lexical-binding: t; -*-
;;; Commentary:
;;; We use `straight.el' for package management
;;; Code:

(setq package-enable-at-startup nil
      straight-cache-autoloads t
      straight-check-for-modifications '(check-on-save find-when-checking)
      straight-repository-branch "develop"
      straight-use-package-by-default t
      use-package-always-ensure nil)

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

(setq straight-use-package-by-default t)

(defun straight-x-clean-unused-repos ()
  "Clean module repos that are unused."
  (interactive)
  (dolist (repo (straight--directory-files (straight--repos-dir)))
    (unless (or (straight--checkhash repo straight--repo-cache)
                (not (y-or-n-p (format "Delete repository %S?" repo))))
      (delete-directory (straight--repos-dir repo) 'recursive 'trash))))

(use-package no-littering :init (require 'no-littering))

(add-to-list 'load-path (concat user-emacs-directory "elisp"))
(add-to-list 'load-path (concat user-emacs-directory "elisp/lang"))

;;; early-init.el ends here
