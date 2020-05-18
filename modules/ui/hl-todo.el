;;; hl-todo.el --- highlight keywords -*- lexical-binding: t; -*-
;;; Commentary:
;; highlight TODO/HACK/FIXME/NOTE
;;; Code:
(use-package hl-todo
  :hook (prog-mode . hl-todo-mode)
  :custom (hl-todo-keyword-faces
           `(("TODO"  . ,(face-foreground 'warning))
             ("HACK" . ,(face-foreground 'error))
             ("FIXME" . ,(face-foreground 'error))
             ("NOTE"  . ,(face-foreground 'success)))))
;;; hl-todo.el ends here
