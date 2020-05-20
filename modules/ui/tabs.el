;;; tabs.el --- Tabs like those other editors -*- lexical-binding: t; -*-
;;; Commentary:
;; thank God for `centaur-tabs'
;;; Code:
(setq x-underline-at-descent-line t)
(use-package centaur-tabs
  :hook (after-change-major-mode . centaur-tabs-mode)
  :custom
  (centaur-tabs-height 30)
  (centaur-tabs-set-icons t)
  (centaur-tabs-set-bar 'under)
  (centaur-tabs-set-modified-marker t))
;;; tabs.el ends here
