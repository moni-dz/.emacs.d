;;; search-selectrum.el --- better solution for incremental narrowing -*- lexical-binding: t; -*-
;;; Commentary:
;; i am now an `ivy' hater
;; more raxod502 stuff for me
;;; Code:
(use-package selectrum :hook (after-init . selectrum-mode))
(use-package selectrum-prescient :hook (selectrum-mode . selectrum-prescient-mode))
;;; search-selectrum.el ends here
