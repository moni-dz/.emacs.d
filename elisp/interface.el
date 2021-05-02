;;; -*- lexical-binding: t -*-

(pkg! hide-mode-line
  :hook
  ((comint-mode helpful-mode help-mode) . hide-mode-line-mode))

(pkg! ivy
  :hook
  (emacs-startup . ivy-mode)
  :custom
  (ivy-use-virtual-buffers t)
  (enable-recustive-minibuffers t)
  (ivy-use-selectable-prompt t))

(pkg! ivy-rich
  :after ivy
  :hook
  (ivy-mode . ivy-rich-mode))

(pkg! counsel
  :after ivy
  :bind
  ("C-c C-t" . counsel-load-theme)
  :hook
  (emacs-startup . counsel-mode))

(pkg! swiper
  :after ivy
  :bind
  ("C-s" . swiper))

(pkg! prescient
  :hook
  (emacs-startup . prescient-persist-mode))

(pkg! ivy-prescient
  :hook
  (emacs-startup . ivy-prescient-mode))

(pkg! helpful
  :bind
  (("C-h f" . helpful-callable)
   ("C-h v" . helpful-variable)
   ("C-h k" . helpful-key))
  :config
  (custom-theme-set-faces
   'user
   '(helpful-heading ((t (:inherit variable-pitch))))))

(pkg! centaur-tabs
  :hook
  ((dashboard-mode dired-mode) . centaur-tabs-local-mode)
  :config
  (centaur-tabs-mode +1)
  :custom
  (centaur-tabs-style "bar")
  (centaur-tabs-set-bar 'under)
  (x-underline-at-descent-line t))

(pkg! solaire-mode
  :hook
  ((change-major-mode . turn-on-solaire-mode)
   (after-revert . turn-on-solaire-mode)
   (ediff-prepare-buffer . solaire-mode)
   (minibuffer-setup . solaire-mode-in-minibuffer))
  :custom
  (solaire-mode-auto-swap-bg nil)
  :config
  (solaire-global-mode +1))

(pkg! doom-themes
  :after solaire-mode
  :hook
  (emacs-startup . (lambda () (load-theme 'doom-horizon t)))
  :config
  (doom-themes-visual-bell-config)
  (doom-themes-org-config)
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t))

(pkg! doom-modeline
  :hook
  (emacs-startup . doom-modeline-mode)
  :custom
  (doom-modeline-height 20)
  (doom-modeline-bar-width 4)
  (doom-modeline-icon nil)
  (doom-modeline-enable-word-count t)
  (doom-modeline-indent-info t))

(pkg! olivetti
  :custom
  (olivetti-body-width 120))

(pkg! display-line-numbers
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

(pkg! which-key
  :hook
  (emacs-startup . which-key-mode))

(pkg! page-break-lines
  :hook
  (emacs-startup . global-page-break-lines-mode))

(pkg! dashboard
  :preface
  (defun dashboard-init-info-with-gcs ()
    "Set a dashboard banner including information on package initialization
  time and garbage collections."
    (setq dashboard-init-info
          (format "Ready in %s with %d packages loaded and %d garbage collections."
                  (emacs-init-time) (length pkg!-installed) gcs-done)))
  :hook
  ((after-init . dashboard-setup-startup-hook)
   (emacs-startup . dashboard-refresh-buffer)
   (dashboard-mode . dashboard-init-info-with-gcs))
  :custom
  (dashboard-startup-banner
   (concat user-emacs-directory "assets/slark.png"))
  (dashboard-banner-logo-title "everyone's favorite lisp interpreter")
  (dashboard-center-content t)
  (dashboard-footer-icon "")
  (dashboard-footer-messages
   '("When I say a thing, you know it's true. So I'm calling it right here and now. This one's in the bag!"))
  (dashboard-items '((recents . 4) (projects . 2)))
  (dashboard-show-shortcuts nil)
  (dashboard-set-navigator t)
  (dashboard-navigator-buttons
   `(((,""
       "Theme"
       "Change theme temporarily"
       (lambda (&rest _) (counsel-load-theme))
       font-lock-keyword-face)
      (""
       "GitHub"
       "Go to GitHub page of this Emacs configuration"
       (lambda (&rest _) (browse-url "https://github.com/fortuneteller2k/.emacs.d"))
       font-lock-warning-face)
      (""
       "Config"
       "Find file in `user-emacs-directory'"
       (lambda (&rest _) (counsel-find-file user-emacs-directory))
       font-lock-warning-face)
      (""
       "Update"
       "Update packages using `straight-pull-all'"
       (lambda (&rest _) (straight-pull-all))
       error)))))

(provide 'interface)
