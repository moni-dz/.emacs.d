;;; horizon.el --- Horizon from VSCode -*- lexical-binding: t; -*-
;;; Commentary:
;; mmm yeah horizon
;;; Code:
(use-package doom-themes
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  :config (load-theme 'doom-horizon t))

(with-eval-after-load 'org
  (set-face-attribute 'org-level-1
                      nil
                      :background (face-background 'default)
                      :height 1.0))
;;; monokai-pro.el ends here
