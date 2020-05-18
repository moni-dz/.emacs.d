;;; project.el --- Project management -*- lexical-binding: t; -*-
;;; Commentary:
;; Projectile for project management
;;; Code:
(defun f2k--file-exists-p (path)
  "Determine if PATH exists."
  (and (file-exists-p path) path))

(use-package projectile
  :hook (emacs-startup . projectile-mode)
  :bind-keymap ("C-c p" . projectile-command-map)
  :custom
  (projectile-project-search-path (list (f2k--file-exists-p "~/projects")))
  (projectile-indexing-method (if (memq system-type '(ms-dos windows-nt cygwin)) 'native 'alien))
  (projectile-sort-order 'access-time)
  (projectile-enable-caching t)
  (projectile-require-project-root t)
  (projectile-completion-system 'ivy)
  :config (projectile-mode t))
;;; project.el ends here

