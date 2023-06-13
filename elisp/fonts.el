;;; -*- lexical-binding: t -*-

(elpaca-leaf persistent-soft :require t)

(elpaca-leaf unicode-fonts
  :after persistent-soft
  :require t
  :config (unicode-fonts-setup))

(elpaca-leaf fontaine
  :require t
  :hook ((modus-themes-after-load-theme-hook after-init-hook) . fontaine-apply-current-preset)
  :config
  (fontaine-set-preset 'regular)
  
  (defun fonts/family-from-face (prop)
    (plist-get (cdr (car (last fontaine-presets))) prop))
  :custom
  (fontaine-presets . '((tiny :default-height 90)
                        (small :default-height 110)
                        (regular :default-height 130)
                        (medium :default-height 150)
                        (large :default-height 190)
                        (presentation :default-height 210)
                        (jumbo :default-height 230)
                        (t
                         :default-family "Comic Code Ligatures"
                         :default-weight medium
                         :default-height 130
                         :fixed-pitch-family nil
                         :fixed-pitch-weight nil
                         :fixed-pitch-height 1.0
                         :fixed-pitch-serif-family "Comic Neue"
                         :fixed-pitch-serif-weight nil
                         :fixed-pitch-serif-height 1.05
                         :variable-pitch-family "Comic Neue"
                         :variable-pitch-weight nil
                         :variable-pitch-height 1.05
                         :bold-family nil
                         :bold-weight bold
                         :italic-family nil
                         :italic-slant italic
                         :line-spacing-nil))))

(elpaca-leaf ligature
  :config
  (ligature-set-ligatures 'prog-mode '("<---" "<--"  "<<-" "<-" "->" "-->" "--->" "<->" "<-->" "<--->" "<---->" "<!--"
                                       "<==" "<===" "<=" "=>" "=>>" "==>" "===>" ">=" "<=>" "<==>" "<===>" "<====>"
                                       "<~~" "<~" "~>" "~~>" "::" ":::" "==" "!=" "===" "!=="
                                       ":=" ":-" ":+" "<*" "<*>" "*>" "<|" "|>" "+:" "-:" "=:" "<******>" "++" "+++"))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

(provide 'fonts)
