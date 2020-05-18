;;; path.el --- Inherit PATH  -*- lexical-binding: t; -*-
;;; Commentary:
;; Inherit the shell's $PATH
;;; Code:
(with-os! (gnu/linux darwin)
  (use-package exec-path-from-shell
    :config
    (exec-path-from-shell-initialize)))
;;; path.el ends here
