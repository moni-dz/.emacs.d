;;; core-ui.el --- The pretty part of the configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; We define all the pretty stuff here
;;; Code:
(set-face-attribute 'default nil
		                :family "JetBrains Mono"
		                :height 90
		                :weight 'bold
		                :width 'normal)

(set-face-attribute 'variable-pitch nil
                    :family "Recursive Sans Casual Static"
                    :height 120
                    :weight 'normal
                    :width 'normal)

(use-package dashboard
  :hook (after-init . dashboard-setup-startup-hook)
  :custom
  (dashboard-banner-logo-title "GNU Emacs")
  (dashboard-startup-banner (concat f2k-dir "assets/emacs.png"))
  (dashboard-set-init-info nil)
  (dashboard-center-content t)
  (dashboard-show-shortcuts nil)
  (dashboard-items '((recents . 5) (projects . 5)))
  (dashboard-set-init-info nil)
  (dashboard-set-navigator t)
  (dashboard-set-footer nil))

(line-number-mode t)
(column-number-mode t)

(defun f2k/enable-ligatures ()
  "Define JetBrains Mono ligatures and load them with harfbuzz."
  (let ((alist '((?! . "\\(?:!\\(?:==\\|[!=]\\)\\)")
                 (?# . "\\(?:#\\(?:###?\\|_(\\|[!#(:=?[_{]\\)\\)")
                 (?$ . "\\(?:\\$>\\)")
                 (?& . "\\(?:&&&?\\)")
                 (?* . "\\(?:\\*\\(?:\\*\\*\\|[/>]\\)\\)")
                 (?+ . "\\(?:\\+\\(?:\\+\\+\\|[+>]\\)\\)")
                 (?- . "\\(?:-\\(?:-[>-]\\|<<\\|>>\\|[<>|~-]\\)\\)")
                 (?. . "\\(?:\\.\\(?:\\.[.<]\\|[.=?-]\\)\\)")
                 (?/ . "\\(?:/\\(?:\\*\\*\\|//\\|==\\|[*/=>]\\)\\)")
                 (?: . "\\(?::\\(?:::\\|\\?>\\|[:<-?]\\)\\)")
                 (?\; . "\\(?:;;\\)")
                 (?< . "\\(?:<\\(?:!--\\|\\$>\\|\\*>\\|\\+>\\|-[<>|]\\|/>\\|<[<=-]\\|=\\(?:=>\\|[<=>|]\\)\\||\\(?:||::=\\|[>|]\\)\\|~[>~]\\|[$*+/:<=>|~-]\\)\\)")
                 (?= . "\\(?:=\\(?:!=\\|/=\\|:=\\|=[=>]\\|>>\\|[=>]\\)\\)")
                 (?> . "\\(?:>\\(?:=>\\|>[=>-]\\|[]:=-]\\)\\)")
                 (?? . "\\(?:\\?[.:=?]\\)")
                 (?\[ . "\\(?:\\[\\(?:||]\\|[<|]\\)\\)")
                 (?\ . "\\(?:\\\\/?\\)")
                 (?\] . "\\(?:]#\\)")
                 (?^ . "\\(?:\\^=\\)")
                 (?_ . "\\(?:_\\(?:|?_\\)\\)")
                 (?{ . "\\(?:{|\\)")
                 (?| . "\\(?:|\\(?:->\\|=>\\||\\(?:|>\\|[=>-]\\)\\|[]=>|}-]\\)\\)")
                 (?~ . "\\(?:~\\(?:~>\\|[=>@~-]\\)\\)"))))
    (dolist (char-regexp alist)
      (set-char-table-range composition-function-table (car char-regexp)
                            `([,(cdr char-regexp) 0 compose-gstring-for-graphic])))))

(add-hook 'after-init-hook #'f2k/enable-ligatures)

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :custom
  (doom-modeline-height 25)
  (doom-modeline-bar-width 3)
  (doom-modeline-major-mode-icon t)
  (doom-modeline-major-mode-color-icon t)
  (doom-modeline-indent-info t)
  :config (display-battery-mode +1))

(use-package hide-mode-line
  :hook ((comint-mode help-mode) . hide-mode-line-mode))

(when (display-graphic-p)
  (add-hook 'prog-mode-hook #'hl-line-mode))

(use-package display-line-numbers
  :hook ((prog-mode . display-line-numbers-mode)
         (org-mode . display-line-numbers-mode))
  :custom
  (display-line-numbers-type 'relative)
  (display-line-numbers-current-absolute t)
  (display-line-numbers-width 2)
  (display-line-numbers-widen t))

(provide 'core-ui)
;;; core-ui.el ends here
