;;; -*- lexical-binding: t -*-

(setq-default modus-themes-mixed-fonts t)

;;;###autoload
(defun interface/dynamic-theme ()
  "Load theme, depending on mode. (only for macOS)"
  (interactive)

  (mapc #'disable-theme custom-enabled-themes)

  (let ((mode (plist-get (mac-application-state) :appearance)))
    (cond ((equal mode "NSAppearanceNameAqua")
           (load-theme 'doom-one-light t))
          ((equal mode "NSAppearanceNameDarkAqua")
           (load-theme 'doom-monokai-pro t)))))

(elpaca-leaf doom-themes
  :after fontaine
  :init
  (if (eq system-type 'darwin)
      (dolist (hook '(mac-effective-appearance-change-hook elpaca-after-init-hook elpaca-ui-mode-hook))
        (add-hook hook #'interface/dynamic-theme))
    (dolist (hook '(elpaca-after-init-hook elpaca-ui-mode-hook))
      (add-hook hook #'(lambda () (load-theme 'doom-monokai-pro t))))))

(elpaca-leaf (conceal :host github :repo "lepisma/conceal"))

(elpaca-leaf (which-key :host github :repo "justbur/emacs-which-key")
  :hook (emacs-startup-hook . which-key-mode))

(elpaca-leaf solaire-mode
  :custom (solaire-mode-auto-swap-bg . nil)
  :hook (window-setup-hook . solaire-global-mode))

(elpaca-leaf blackout
  :config
  (blackout 'emacs-lisp-mode "Emacs Lisp"))

(elpaca-leaf doom-modeline
  :after (fontaine blackout)
  :hook ((elpaca-after-init-hook elpaca-ui-mode-hook window-setup-hook) . doom-modeline-mode)
  :custom
  (doom-modeline-hud . t)
  (doom-modeline-height . 20)
  (doom-modeline-bar-width . 0)
  (doom-modeline-icon . nil)
  :custom-face
  (doom-modeline-evil-motion-state . '((t (:inherit (doom-modeline font-lock-doc-face) :family "Comic Code Ligatures"))))
  (doom-modeline-buffer-file . '((t (:inherit (doom-modeline mode-line-buffer-id bold) :family "Comic Neue" :weight bold :height 1.3))))
  (doom-modeline-buffer-modified . '((t (:inherit (doom-modeline warning bold) :family "Comic Neue" :weight bold :height 1.3))))
  (doom-modeline-buffer-major-mode . '((t (:inherit (doom-modeline-emphasis bold) :family "Comic Neue" :weight bold :height 1.3)))))

(elpaca-leaf (vertico :files (:defaults "extensions/*"))
  :config
  ;; style vertico's prompt
  (advice-add
   #'vertico--format-candidate
   :around #'(lambda (orig cand prefix suffix index _start)
               (setq cand (funcall orig cand prefix suffix index _start))
               (concat
                (if (= vertico--index index)
                    (propertize "→ " 'face 'vertico-current)
                  "  ")
                cand)))

  (vertico-mode)
  (vertico-reverse-mode))

(elpaca-leaf marginalia
  :after vertico
  :config (marginalia-mode))

(elpaca-leaf vertico-prescient
  :after vertico
  :config (vertico-prescient-mode))

(leaf savehist :config (savehist-mode))

(leaf emacs
  :init
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
  :custom-face (helpful-heading . '((t (:family "Comic Neue")))))

(elpaca-leaf (olivetti :host github :repo "rnkn/olivetti")
  :after fontaine
  :custom
  (olivetti-body-width . 0.6)
  (olivetti-recall-visual-line-mode-entry-state . t))

(elpaca-leaf hide-mode-line)

(leaf display-line-numbers
  :hook ((prog-mode-hook org-mode-hook) . display-line-numbers-mode)
  :custom
  (display-line-numbers-width . 3)
  (display-line-numbers-widen . t))

;;;###autoload
(define-minor-mode zen-mode
  "A distraction-free environment for writing."
  :global nil

  (if zen-mode
      (progn
        (olivetti-mode +1)
        (hide-mode-line-mode +1)
        (fontaine-set-preset 'medium)
        (display-line-numbers-mode -1))
    (progn
      (olivetti-mode -1)
      (hide-mode-line-mode -1)
      (fontaine-set-preset 'regular)
      (display-line-numbers-mode +1))))

;;;###autoload
(defun zen--revert-font-changes (&rest t)
  "Revert normal font size when swapping buffers."
  (if (bound-and-true-p zen-mode)
      (fontaine-set-preset 'medium)
    (fontaine-set-preset 'regular)))

(add-hook
 'window-setup-hook
 #'(lambda ()
     (add-hook 'find-file-hook #'zen--revert-font-changes)

     (dolist (fun '(switch-to-buffer previous-buffer next-buffer))
       (advice-add fun :after #'zen--revert-font-changes))))

(global-set-key (kbd "C-x z") #'zen-mode)

(elpaca-leaf page-break-lines :hook (window-setup-hook . global-page-break-lines-mode))

(defconst interface/show-splash-image (display-graphic-p) "Whether to show the splash image or not.")

;;;###autoload
(defun interface/splash ()
  "Make a splash!"

	(let ((buf (get-buffer-create "*moni*")))
		(with-current-buffer buf
		  (let ((inhibit-read-only t)
            (header-line-text (replace-regexp-in-string "\n" "" (emacs-version))))

        (setq-local cursor-type nil ; this doesn't get set wtf
                    vertical-scroll-bar nil
                    horizontal-scroll-bar nil
                    header-line-format nil)

        (hide-mode-line-mode +1)
        (erase-buffer)
			  (make-local-variable 'startup-screen-inhibit-startup-screen)

        (let* ((splash-text " fastest blade in the land ")
               (splash-image (create-image (expand-file-name "assets/bleeding_eyes_moni.png" user-emacs-directory)))
               (startup-time-text (format " Started in %s with %d garbage collections. " (emacs-init-time) gcs-done)))

          (if interface/show-splash-image
              (progn
                (insert-char ?\n 3)
			          (insert (propertize " " 'display `(space :align-to (+ center (-0.5 . ,splash-image)))))
                (insert-image splash-image)
                (insert-char ?\n 3))
            (insert-char ?\n 15))

			    (insert (propertize " " 'display `(space :align-to (+ center (-0.65 . ,(length splash-text))))))
			    (insert (propertize splash-text 'face '(:inherit marginalia-modified :family "Comic Neue" :height 2.0)))

          (insert-char ?\n 7)
			    (insert (propertize " " 'display `(space :align-to (+ center (-0.5 . ,(length startup-time-text))))))
          (insert (propertize startup-time-text 'face '(:inherit custom-saved :family "Comic Neue" :height 1.5)))))
      (switch-to-buffer buf)
      (beginning-of-buffer)
      (setq-local buffer-read-only t))))

(dolist (hook '(window-setup-hook elpaca-after-init-hook))
  (add-hook hook #'interface/splash))

(provide 'interface)
