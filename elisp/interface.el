;;; -*- lexical-binding: t -*-

(setq-default modus-themes-mixed-fonts t)

(defun interface/dynamic-theme (mode)
  "Load theme, depending on MODE. (only for macOS)"
  (mapc #'disable-theme custom-enabled-themes)
  (pcase mode
    ('light (load-theme 'modus-operandi-tinted t))
    ('dark (load-theme 'modus-vivendi-tinted t))))

(if (eq system-type 'darwin)
    (add-hook 'ns-system-appearance-change-functions #'interface/dynamic-theme)
  (load-theme 'modus-operandi-tinted t))

(let ((header-line-enabled t))
  (defun interface/toggle-header-line ()
    "Toggle header line"
    (interactive)
    
    (if header-line-enabled
        (setq header-line-format nil)
      (setq header-line-format '(:eval simple-modeline--mode-line)))  

    (setq header-line-enabled (not header-line-enabled))))

(dolist (hook '(comint-mode-hook helpful-mode-hook help-mode-hook))
  (add-hook hook #'interface/toggle-header-line))

(elpaca-leaf (conceal :host github :repo "lepisma/conceal"))

(elpaca-leaf blackout
  :config
  (blackout 'emacs-lisp-mode "Emacs Lisp"))

(elpaca-leaf simple-modeline
  :after blackout
  :require t
  :config
  (setq-default header-line-format '(:eval simple-modeline--mode-line))

  (defun blackout-minor-modes ()
    (blackout 'gcmh-mode)
    (blackout 'visual-line-mode)
    (blackout 'highlight-indent-guides-mode)
    (blackout 'yas-minor-mode)
    (blackout 'smartparens-mode)
    (blackout 'eldoc-mode)
    (blackout 'super-save-mode)
    (blackout 'which-key-mode)
    (blackout 'buffer-face-mode)
    (blackout 'word-wrap-whitespace-mode)
    (blackout 'page-break-lines-mode))

  (add-hook 'window-setup-hook #'blackout-minor-modes)
  (add-hook 'after-change-major-mode-hook #'blackout-minor-modes))

(elpaca-leaf (conceal :host github :repo "lepisma/conceal"))
(elpaca-leaf vertico :config (vertico-mode))
(leaf savehist :config (savehist-mode))

(leaf emacs
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
  ;; Vertico commands are hidden in normal buffers.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))

(elpaca-leaf helpful
  :bind
  (("C-h f" . helpful-callable)
   ("C-h v" . helpful-variable)
   ("C-h k" . helpful-key))
  :custom-face (helpful-heading . '((t (:inherit variable-pitch)))))

(elpaca-leaf solaire-mode
  :hook
  ((change-major-mode-hook . turn-on-solaire-mode)
   (after-revert-hook . turn-on-solaire-mode)
   (ediff-prepare-buffer-hook . solaire-mode))
  :custom
  (solaire-mode-auto-swap-bg . nil)
  :config
  (solaire-global-mode +1))

(elpaca-leaf olivetti
  :after fontaine
  :custom
  (olivetti-body-width . 0.7)
  (olivetti-minimum-body-width . 80)
  (olivetti-recall-visual-line-mode-entry-state . t))

(leaf display-line-numbers
  :hook ((prog-mode-hook org-mode-hook) . display-line-numbers-mode)
  :custom
  (display-line-numbers-width . 3)
  (display-line-numbers-widen . t))

(defun interface/toggle-zen-mode ()
  "Toggle a distraction-free environment for writing."
  (interactive)

  (cond ((bound-and-true-p olivetti-mode)
         (fontaine-set-preset 'regular)
         (olivetti-mode -1)
         (display-line-numbers-mode +1)
         (setq header-line-format '(:eval simple-modeline--mode-line)))
        (t
         (fontaine-set-preset 'large)
         (olivetti-mode +1)
         (display-line-numbers-mode -1)
         (setq header-line-format nil))))

(global-set-key (kbd "C-x z") 'interface/toggle-zen-mode)

(elpaca-leaf which-key :hook (emacs-startup-hook . which-key-mode))
(elpaca-leaf page-break-lines :hook (emacs-startup-hook . global-page-break-lines-mode))

(defun interface/splash ()
  "Make a splash!"
  
	(let ((buf (get-buffer-create "*moni*")))
		(with-current-buffer buf
		  (let ((inhibit-read-only t))
			  (erase-buffer)

        (setq-local header-line-format nil
                    cursor-type nil ; this doesn't get set wtf
                    vertical-scroll-bar nil
                    horizontal-scroll-bar nil)

			  (make-local-variable 'startup-screen-inhibit-startup-screen)

        (let ((splash-text "hey")
              (startup-time-text (format "Emacs started in %s." (emacs-init-time))))

          (insert-char ?\n 7)
			    (insert (propertize " " 'display `(space :align-to (+ center (-0.5 . ,(length splash-text))))))
			    (insert splash-text)
          (insert-char ?\n 7)
			    (insert (propertize " " 'display `(space :align-to (+ center (-0.5 . ,(length startup-time-text))))))
          (insert startup-time-text)))
      
		  (setq buffer-read-only t))
    (switch-to-buffer buf)))

(add-hook 'window-setup-hook #'interface/splash)

(provide 'interface)
