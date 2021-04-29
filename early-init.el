;;; early-init.el --- Package management -*- lexical-binding: t; -*-
;;; Commentary:
;;; We use `straight.el' for package management, and early frame modifications
;;; Code:

(tooltip-mode -1)

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

(when (featurep 'ns)
  (push '(ns-transparent-titlebar . t) default-frame-alist))

(setq ring-bell-function 'ignore
      visible-bell nil
      uniquify-buffer-name-style 'post-forward-angle-brackets
      inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t
      initial-scratch-message nil
      package-enable-at-startup nil
      straight-cache-autoloads t
      straight-check-for-modifications '(check-on-save find-when-checking)
      straight-repository-branch "develop")

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

(setq straight-use-package-by-default t
      use-package-always-ensure nil
      use-package-always-defer t)

(defun straight-x-clean-unused-repos ()
  "Clean module repos that are unused."
  (interactive)
  (dolist (repo (straight--directory-files (straight--repos-dir)))
    (unless (or (straight--checkhash repo straight--repo-cache)
                (not (y-or-n-p (format "Delete repository %S?" repo))))
      (delete-directory (straight--repos-dir repo) 'recursive 'trash))))

(use-package no-littering
  :demand t
  :config
  (require 'no-littering))

(add-to-list 'load-path (concat user-emacs-directory "elisp"))
(add-to-list 'load-path (concat user-emacs-directory "elisp/lang"))

;;; early-init.el ends here
