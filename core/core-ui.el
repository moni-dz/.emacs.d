;;; core-ui.el --- The pretty part of the configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; We define all the pretty stuff here
;;; Code:
(use-package dashboard
  :hook (after-init . dashboard-setup-startup-hook)
  :custom
  (dashboard-banner-logo-title "GNU Emacs")
  (dashboard-startup-banner (concat f2k-dir "assets/emacs.png"))
  (dashboard-set-init-info nil)
  (dashboard-center-content t)
  (dashboard-show-shortcuts nil)
  (dashboard-items '((recents . 5) (projects . 5)))
  (dashboard-set-init-info nil)
  (dashboard-set-navigator t)
  (dashboard-set-footer nil))

(line-number-mode t)
(column-number-mode t)

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :custom
  (doom-modeline-height 25)
  (doom-modeline-bar-width 3)
  (doom-modeline-major-mode-icon t)
  (doom-modeline-major-mode-color-icon t)
  (doom-modeline-indent-info t)
  :config (display-battery-mode +1))

(use-package vi-tilde-fringe :hook (prog-mode . vi-tilde-fringe-mode))

(use-package hide-mode-line :hook ((comint-mode help-mode) . hide-mode-line-mode))

(when (display-graphic-p)
  (add-hook 'prog-mode-hook #'hl-line-mode))

(use-package display-line-numbers
  :hook ((prog-mode . display-line-numbers-mode)
         (org-mode . display-line-numbers-mode))
  :custom
  (display-line-numbers-type 'relative)
  (display-line-numbers-current-absolute t)
  (display-line-numbers-width 2)
  (display-line-numbers-widen t))

(provide 'core-ui)
;;; core-ui.el ends here
