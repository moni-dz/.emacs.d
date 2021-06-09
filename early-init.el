;;; early-init.el --- Package management -*- lexical-binding: t; -*-
;;; Commentary:
;;; We use `straight.el' for package management, and early frame modifications
;;; Code:

(tooltip-mode -1)

(add-to-list 'default-frame-alist '(menu-bar-lines . 0))
(add-to-list 'default-frame-alist '(tool-bar-lines . 0))
(add-to-list 'default-frame-alist '(font . "Iosevka FT Light-10.5"))
(add-to-list 'default-frame-alist '(vertical-scroll-bars))

(when (featurep 'ns)
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t)))

(setq-default use-dialog-box nil
              custom-file (if (memq system-type '(gnu/linux darwin)) "/dev/null" "NUL")
              frame-inhibit-implied-resize t
              ring-bell-function 'ignore
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

(setq-default straight-use-package-by-default t
              use-package-always-ensure nil
              use-package-always-defer t)

(defvar pkg!-installed '(straight use-package)
  "List of installed packages.")

(defconst pkg!-font-lock-keywords
  '(("(\\(pkg!\\)\\_>[ \t']*\\(\\(?:\\sw\\|\\s_\\)+\\)?"
     (1 font-lock-keyword-face)
     (2 font-lock-constant-face nil t))))

(font-lock-add-keywords 'emacs-lisp-mode pkg!-font-lock-keywords)

(defmacro pkg! (name &rest args)
  "`use-package' macro that increments `pkg!-installed'.
With the added bonus that it's also shorter and less cumbersome."
  (declare (indent defun))
  (add-to-list 'pkg!-installed name)
  `(use-package ,name
     ,@args))

(defun straight-x-clean-unused-repos ()
  "Clean module repos that are unused."
  (interactive)
  (dolist (repo (straight--directory-files (straight--repos-dir)))
    (unless (or (straight--checkhash repo straight--repo-cache)
                (not (y-or-n-p (format "Delete repository %S?" repo))))
      (delete-directory (straight--repos-dir repo) 'recursive 'trash))))

(pkg! no-littering
  :demand t
  :config
  (require 'no-littering))

(pkg! exec-path-from-shell
  :if (memq window-system '(mac ns x))
  :demand t
  :config
  (exec-path-from-shell-initialize))

(add-to-list 'load-path (concat user-emacs-directory "elisp"))
(add-to-list 'load-path (concat user-emacs-directory "elisp/lang"))

;;; early-init.el ends here
