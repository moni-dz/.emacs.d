;;; writeroom.el --- Distraction free writing / coding -*- lexical-binding: t; -*-
;;; Commentary:
;; my favorite mode
;;; Code:
(use-package writeroom-mode
  :config
  (advice-add #'text-scale-adjust :after #'visual-fill-column-adjust))
;;; writeroom.el ends here
