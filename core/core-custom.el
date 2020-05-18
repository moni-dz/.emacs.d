;;; core-custom.el --- Initializes variables -*- lexical-binding: t -*-
;;; Commentary:
;; Defines variables and constants used throughout the configuration
;;; Code:

(defvar f2k--modules nil
  "List containing the loaded modules, filled by `load!'.
Contains atom or cons where the head is the module and the rest are the features to enable for that module.")
(provide 'core-custom)
;;; core-custom.el ends here
