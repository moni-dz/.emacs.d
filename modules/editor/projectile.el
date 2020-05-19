;;; projectile.el --- Project management -*- lexical-binding: t; -*-
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
  (projectile-completion-system 'ivy)
  (projectile-project-search-path (list (f2k--file-exists-p "~/projects/rust")
                                        (f2k--file-exists-p "~/projects/clang")
                                        (f2k--file-exists-p "~/go/src/github.com/fortuneteller2k")))
  (projectile-indexing-method (if (memq system-type '(ms-dos windows-nt cygwin)) 'native 'alien))
  (projectile-sort-order 'access-time)
  (projectile-enable-caching t)
  (projectile-require-project-root t)
  :config (projectile-mode t))

(use-package counsel-projectile
  :if (module-p! :ui ivy)
  :after (counsel projectile)
  :config (counsel-projectile-mode t))
;;; projectile.el ends here

