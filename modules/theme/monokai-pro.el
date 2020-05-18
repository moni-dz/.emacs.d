;;; monokai-pro.el --- The best version of monokai -*- lexical-binding: t; -*-
;;; Commentary:
;; The "paid" version of monokai
;;; Code:
(use-package doom-themes
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  :config (load-theme 'doom-monokai-pro t))

(with-eval-after-load 'org
  (set-face-attribute 'org-level-1
                      nil
                      :background (face-background 'default)
                      :height 1.0))
;;; monokai-pro.el ends here
