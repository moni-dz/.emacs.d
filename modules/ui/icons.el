;;; icons.el --- Pretty icons -*- lexical-binding: t; -*-
;;; Commentary:
;; all-the-icons
;;; Code:
(use-package all-the-icons
  :if (display-graphic-p)
  :config (unless (find-font (font-spec :name "all-the-icons"))
            (all-the-icons-install-fonts t)))

(with-eval-after-load 'dashboard
  (setq dashboard-set-file-icons t
        dashboard-set-heading-icons t
	      dashboard-navigator-buttons
	      `((
	         (,(all-the-icons-octicon "mark-github" :height 1.1 :v-adjust 0.0)
	          "GitHub"
	          "Browse GitHub"
	          (lambda (&rest _) (browse-url "https://github.com/fortuneteller2k")))
	         (,(all-the-icons-material "update" :height 1.3 :v-adjust -0.24)
	          "Update"
	          "Update packages"
	          (lambda (&rest _) (straight-pull-all)))
           (,(all-the-icons-octicon "tools" :height 1.0 :v-adjust 0.0)
            "Config"
            "Find file in .emacs.d"
            (lambda (&rest _) (find-file f2k-dir)))
	         ))))
;;; icons.el ends here
