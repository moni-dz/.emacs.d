;;; tabs.el --- Tabs like those other editors -*- lexical-binding: t; -*-
;;; Commentary:
;; thank God for `centaur-tabs'
;;; Code:
(setq x-underline-at-descent-line t)
(use-package centaur-tabs
  :custom
  (centaur-tabs-height 30)
  (centaur-tabs-set-icons t)
  (centaur-tabs-set-bar 'under)
  (centaur-tabs-set-modified-marker t)
  (centaur-tabs-change-fonts "Recursive Sans Casual Static" 90)
  :config (centaur-tabs-mode +1))
;;; tabs.el ends here
