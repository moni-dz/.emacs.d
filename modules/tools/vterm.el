;;; vterm.el --- the best terminal emulator -*- lexical-binding: t; -*-
;;; Commentary:
;; all the others suck ngl
;;; Code:
(use-package vterm
  :commands vterm vterm-mode
  :bind ("C-c t" . vterm)
  :preface (setq vterm-install t)
  :hook (vterm-mode . hide-mode-line-mode)
  :custom (vterm-kill-buffer-on-exit t))

(defun +vterm-init-remember-point-h ()
  "Restore the point's location when leaving and re-entering insert mode."
  (add-hook 'evil-insert-state-exit-hook #'+vterm-remember-insert-point-h nil t)
  (add-hook 'evil-insert-state-entry-hook #'+vterm-goto-insert-point-h nil t))

(add-hook 'vterm-mode-hook #'+vterm-init-remember-point-h)
;;; vterm.el ends here
