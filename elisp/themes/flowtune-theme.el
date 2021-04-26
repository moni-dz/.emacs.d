(require 'autothemer)

(deftheme flowtune)

(autothemer-deftheme
 flowtune "fortuneteller2k's theme"

 ((((class color) (min-colors #xFFFFFF))) ;; We're only concerned with graphical Emacs

  ;; Define our color palette
  (bg "#151515")
  (fg "#e2ecf7")
  (red "#ea2e58")
  (green "#3cef85")
  (yellow "#fcd148")
  (blue "#2f93fc")
  (purple "#e03cef")
  (cyan "#40c9f2")
  (bright-yellow "#fcd761"))

 ;; Customize faces
 ((default                   (:foreground fg :background bg))
  (cursor                    (:background red))
  (region                    (:background purple))
  (mode-line                 (:background purple))
  (font-lock-keyword-face    (:foreground purple))
  (font-lock-constant-face   (:foreground green))
  (font-lock-string-face     (:foreground bright-yellow))
  (font-lock-builtin-face    (:foreground green))

  (org-level-1               (:foreground bright-yellow)))

 (custom-theme-set-variables
  'flowtune
  `(ansi-color-names-vector [,red
                             ,green
                             ,blue
                             ,purple
                             ,yellow
                             ,bright-yellow
                             ,cyan]))

 )

(provide-theme 'flowtune)

(provide 'flowtune-theme)
