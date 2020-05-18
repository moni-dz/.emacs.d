;;; rust.el --- Rust language support -*- lexical-binding: t; -*-
;;; Commentary:
;; Support for Rust using `rustic'
;;; Code:
(use-package rustic :custom (rustic-lsp-server 'rls))
(with-eval-after-load 'flycheck (push 'rustic-clippy flycheck-checkers))
;;; rust.el ends here
