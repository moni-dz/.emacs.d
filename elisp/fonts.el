;;; -*- lexical-binding: t -*-

(elpaca-leaf fontaine
  :require t
  :hook (modus-themes-after-load-theme-hook . fontaine-apply-current-preset)
  :config
  (fontaine-set-preset (or (fontaine-restore-latest-preset) 'regular))
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
                         :default-weight regular
                         :default-height 130
                         :fixed-pitch-family nil
                         :fixed-pitch-weight nil
                         :fixed-pitch-height 1.0
                         :fixed-pitch-serif-family "Comic Sans MS"
                         :fixed-pitch-serif-weight nil
                         :fixed-pitch-serif-height 1.4
                         :variable-pitch-family "Comic Sans MS"
                         :variable-pitch-height 1.4
                         :bold-family nil
                         :bold-weight bold
                         :italic-family nil
                         :italic-slant italic
                         :line-spacing-nil))))

(elpaca-leaf ligature
  :config
  ;; Enable all Iosevka ligatures in programming modes
  (ligature-set-ligatures 'prog-mode '("<---" "<--"  "<<-" "<-" "->" "-->" "--->" "<->" "<-->" "<--->" "<---->" "<!--"
                                       "<==" "<===" "<=" "=>" "=>>" "==>" "===>" ">=" "<=>" "<==>" "<===>" "<====>" "<!---"
                                       "<~~" "<~" "~>" "~~>" "::" ":::" "==" "!=" "===" "!=="
                                       ":=" ":-" ":+" "<*" "<*>" "*>" "<|" "<|>" "|>" "+:" "-:" "=:" "<******>" "++" "+++"))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

(provide 'fonts)
