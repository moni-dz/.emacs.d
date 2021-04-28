(tooltip-mode -1)

(push '(internal-border-width . 15) default-frame-alist)
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
      enable-recursive-minibuffers t)

(use-package selectrum
  :init
  (selectrum-mode +1))

(use-package doom-themes
  :init
  (load-theme 'doom-horizon t)
  :config
  (doom-themes-visual-bell-config)
  (doom-themes-org-config)
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t))

(use-package centaur-tabs
  :hook
  (dashboard-mode . centaur-tabs-local-mode)
  :config
  (setq x-underline-at-descent-line t)
  (centaur-tabs-mode +1)
  :custom
  (centaur-tabs-set-bar 'under))

(use-package doom-modeline
  :hook
  (after-init . doom-modeline-mode)
  :custom
  (doom-modeline-height 20)
  (doom-modeline-bar-width 4)
  (doom-modeline-icon nil)
  (doom-modeline-indent-info t))

(use-package olivetti
  :custom
  (olivetti-body-width 120))

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

(use-package display-line-numbers
  :hook
  ((prog-mode org-mode) . display-line-numbers-mode)
  :custom
  (display-line-numbers-width 3)
  (display-line-numbers-widen t))

(use-package which-key
  :hook
  (emacs-startup . which-key-mode))

(use-package page-break-lines)

(use-package dashboard
  :preface
  (defun dashboard-init-info-with-gcs ()
    "Set a dashboard banner including information on package initialization
  time and garbage collections."
    (setq dashboard-init-info
          (format "Ready in %.5f seconds with %d garbage collections."
                  (float-time (time-subtract after-init-time before-init-time)) gcs-done)))
  :config
  (dashboard-setup-startup-hook)
  :custom
  (dashboard-startup-banner (concat user-emacs-directory "assets/emacs.png"))
  (dashboard-banner-logo-title "everyone's favorite lisp interpreter")
  (dashboard-center-content t)
  (dashboard-footer-icon "")
  (dashboard-footer-messages '("When I say a thing, you know it's true. So I'm calling it right here and now. This one's in the bag!"))
  (dashboard-items '((recents . 10)))
  (dashboard-show-shortcuts nil)
  :hook
  ((emacs-startup . dashboard-refresh-buffer)
   (dashboard-mode . dashboard-init-info-with-gcs)))

(provide 'interface)
