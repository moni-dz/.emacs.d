;;; -*- lexical-binding: t -*-

(setq-default modus-themes-mixed-fonts t)

(defun interface/dynamic-theme (mode)
  "Load theme, depending on MODE. (only for macOS)"
  (interactive)
  
  (mapc #'disable-theme custom-enabled-themes)
  (pcase mode
    ('light (load-theme 'ef-frost t))
    ('dark (load-theme 'ef-winter t))))

(elpaca-leaf ef-themes
  :after fontaine
  :hook (ef-themes-post-load-hook . fontaine-apply-current-preset)
  :init
  (if (eq system-type 'darwin)
      (dolist (hook '(elpaca-after-init-hook elpaca-ui-mode-hook ns-system-appearance-change-functions))
        (add-hook hook #'interface/dynamic-theme))
    (dolist (hook '(elpaca-after-init-hook elpaca-ui-mode-hook))
      (add-hook hook (lambda () (load-theme 'ef-winter t))))))

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
(elpaca-leaf which-key :hook (emacs-startup-hook . which-key-mode))
(elpaca-leaf keycast)

(elpaca-leaf solaire-mode
  :custom (solaire-mode-auto-swap-bg . nil)
  :hook (window-setup-hook . solaire-global-mode))

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

  (dolist (hook '(window-setup-hook after-change-major-mode-hook))
    (add-hook hook #'blackout-minor-modes)))

(elpaca-leaf (conceal :host github :repo "lepisma/conceal"))

(elpaca-leaf vertico :config (vertico-mode))

(elpaca-leaf marginalia
  :after vertico
  :config (marginalia-mode))

(elpaca-leaf vertico-prescient
  :after vertico
  :config (vertico-prescient-mode))

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
  (setq read-extended-command-predicate #'command-completion-default-include-p)

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))

(elpaca-leaf helpful
  :bind
  (("C-h f" . helpful-callable)
   ("C-h v" . helpful-variable)
   ("C-h k" . helpful-key))
  :custom-face (helpful-heading . '((t (:inherit variable-pitch)))))

(elpaca-leaf olivetti
  :after fontaine
  :custom
  (olivetti-body-width . 0.8)
  (olivetti-minimum-body-width . 100)
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
         (olivetti-mode -1)
         (fontaine-set-preset 'regular)
         (display-line-numbers-mode +1)
         (setq header-line-format '(:eval simple-modeline--mode-line)))
        (t
         (olivetti-mode +1)
         (fontaine-set-preset 'medium)
         (display-line-numbers-mode -1)
         (setq header-line-format nil))))

(defun interface/revert-zen-font-changes (&rest t)
  "Revert normal font size when swapping buffers."
  (if (bound-and-true-p olivetti-mode)
      (fontaine-set-preset 'medium)
    (fontaine-set-preset 'regular)))

(add-hook
 'window-setup-hook
 (lambda ()
   (add-hook 'find-file-hook #'interface/revert-zen-font-changes)

   (dolist (fun '(switch-to-buffer previous-buffer next-buffer))
     (advice-add fun :after #'interface/revert-zen-font-changes))))

(global-set-key (kbd "C-x z") #'interface/toggle-zen-mode)

(elpaca-leaf page-break-lines :hook (emacs-startup-hook . global-page-break-lines-mode))

(defun interface/splash ()
  "Make a splash!"
  
	(let ((buf (get-buffer-create "*moni*")))
		(with-current-buffer buf
		  (let ((inhibit-read-only t))

        (setq-local header-line-format nil
                    cursor-type nil ; this doesn't get set wtf
                    vertical-scroll-bar nil
                    horizontal-scroll-bar nil)

        (erase-buffer)
			  (make-local-variable 'startup-screen-inhibit-startup-screen)

        (let ((splash-text "ding fucking won")
              (splash-image (create-image (expand-file-name "assets/brilliant.png" user-emacs-directory)))
              (startup-time-text (format "Emacs started in %s." (emacs-init-time))))

          (insert-char ?\n 7)
			    (insert (propertize " " 'display `(space :align-to (+ center (-0.5 . ,splash-image)))))
          (insert-image splash-image)
          
          (insert-char ?\n 3)
			    (insert (propertize " " 'display `(space :align-to (+ center (-0.5 . ,(length splash-text))))))
			    (insert splash-text)
          
          (insert-char ?\n 7)
			    (insert (propertize " " 'display `(space :align-to (+ center (-0.5 . ,(length startup-time-text))))))
          (insert startup-time-text)))
      
		  (setq buffer-read-only t))
    (switch-to-buffer buf)))

(add-hook 'window-setup-hook #'interface/splash)

(provide 'interface)
