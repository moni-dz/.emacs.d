;;; -*- lexical-binding: t -*-

(use-package hide-mode-line
  :hook
  ((comint-mode helpful-mode help-mode) . hide-mode-line-mode))

(use-package selectrum
  :hook
  (emacs-startup . selectrum-mode))

(use-package prescient
  :hook
  (emacs-startup . prescient-persist-mode))

(use-package selectrum-prescient
  :hook
  (emacs-startup . selectrum-prescient-mode))

(use-package helpful
  :bind
  (("C-h f" . helpful-callable)
   ("C-h v" . helpful-variable)
   ("C-h k" . helpful-key))
  :config
  (custom-theme-set-faces
   'user
   '(helpful-heading ((t (:inherit variable-pitch))))))

(use-package centaur-tabs
  :hook
  ((dashboard-mode dired-mode) . centaur-tabs-local-mode)
  :config
  (centaur-tabs-mode +1)
  :custom
  (centaur-tabs-style "bar")
  (centaur-tabs-set-bar 'under)
  (x-underline-at-descent-line t))

(use-package solaire-mode
  :hook
  ((change-major-mode . turn-on-solaire-mode)
   (after-revert . turn-on-solaire-mode)
   (ediff-prepare-buffer . solaire-mode)
   (minibuffer-setup . solaire-mode-in-minibuffer))
  :custom
  (solaire-mode-auto-swap-bg nil)
  :config
  (solaire-global-mode +1))

(use-package doom-themes
  :after solaire-mode
  :hook
  (emacs-startup . (lambda () (load-theme 'doom-horizon t)))
  :after solaire-mode
  :config
  (doom-themes-visual-bell-config)
  (doom-themes-org-config)
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t))

(use-package doom-modeline
  :hook
  (emacs-startup . doom-modeline-mode)
  :custom
  (doom-modeline-height 20)
  (doom-modeline-bar-width 4)
  (doom-modeline-icon nil)
  (doom-modeline-enable-word-count t)
  (doom-modeline-indent-info t))

(use-package olivetti
  :custom
  (olivetti-body-width 120))

(use-package display-line-numbers
  :hook
  ((prog-mode org-mode) . display-line-numbers-mode)
  :custom
  (display-line-numbers-width 3)
  (display-line-numbers-widen t))

(defun interface/toggle-zen-mode ()
  "Toggle a distraction-free environment for writing."
  (interactive)
  (cond ((bound-and-true-p olivetti-mode)
         (olivetti-mode -1)
         (centaur-tabs-local-mode -1)
         (display-line-numbers-mode +1))
        (t
         (olivetti-mode +1)
         (centaur-tabs-local-mode +1)
         (display-line-numbers-mode -1))))

(global-set-key (kbd "C-x z") 'interface/toggle-zen-mode)

(use-package which-key
  :hook
  (emacs-startup . which-key-mode))

;; NOTE: we demand this since `dashboard' needs it
(use-package page-break-lines
  :demand t)

(use-package dashboard
  :after page-break-lines
  :preface
  (defun dashboard-init-info-with-gcs ()
    "Set a dashboard banner including information on package initialization
  time and garbage collections."
    (setq dashboard-init-info
          (format "Ready in %s with %d garbage collections."
                  (emacs-init-time) gcs-done)))
  :config
  (custom-theme-set-faces
   'user
   '(dashboard-items-face ((t (:inherit default)))))
  :custom
  (dashboard-startup-banner
   (concat user-emacs-directory "assets/emacs.png"))
  (dashboard-banner-logo-title "everyone's favorite lisp interpreter")
  (dashboard-center-content t)
  (dashboard-footer-icon "")
  (dashboard-footer-messages
   '("When I say a thing, you know it's true. So I'm calling it right here and now. This one's in the bag!"))
  (dashboard-items '((recents . 10) (projects . 5)))
  (dashboard-show-shortcuts nil)
  :hook
  ((after-init . dashboard-setup-startup-hook)
   (emacs-startup . dashboard-refresh-buffer)
   (dashboard-mode . dashboard-init-info-with-gcs)))

(provide 'interface)
