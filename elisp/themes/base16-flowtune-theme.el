;; base16-3024-theme.el -- A base16 colorscheme

;;; Commentary:
;; Base16: (https://github.com/chriskempson/base16)

;;; Authors:
;; Scheme: fortuneteller2k (http://github.com/fortuneteller2k)
;; Template: Kaleb Elwert <belak@coded.io>

;;; Code:

(require 'base16-theme)

(defvar base16-flowtune-colors
  '(:base00 "#151515"
    :base01 "#202020"
    :base02 "#252525"
    :base03 "#525252"
    :base04 "#707070"
    :base05 "#e2ecf7"
    :base06 "#f1f6fb"
    :base07 "#f6f9fd"
    :base08 "#ea2e58"
    :base09 "#ec456b"
    :base0A "#fcd148"
    :base0B "#3cef85"
    :base0C "#40c9f2"
    :base0D "#2f93fc"
    :base0E "#e454f1"
    :base0F "#fcd761")
  "All colors for Base16 Flowtune are defined here.")

;; Define the theme
(deftheme base16-flowtune)

;; Add all the faces to the theme
(base16-theme-define 'base16-flowtune base16-flowtune-colors)

;; Mark the theme as provided
(provide-theme 'base16-flowtune)

(provide 'base16-flowtune-theme)

;;; base16-3024-theme.el ends here
