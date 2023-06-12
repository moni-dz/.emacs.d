;;; -*- lexical-binding: t -*-

;; native compilation
(with-eval-after-load 'comp
  (setq native-comp-async-jobs-number 8
        native-comp-speed 3))

;;;###autoload
(defun optimizations/eagerly-native-comp-packages ()
  (interactive)
  (native-compile-async (concat user-emacs-directory "init.el"))
  (native-compile-async (concat user-emacs-directory "early-init.el"))
  (native-compile-async (concat user-emacs-directory "elpaca") 'recursively))

;; Temporarily save the file-name-handler-alist
(defvar temp-file-name-handler-alist file-name-handler-alist)

;; Ignore .Xresources
(advice-add #'x-apply-session-resources :override #'ignore)

(setq-default file-name-handler-alist nil
              create-lockfiles nil
              bidi-display-reordering nil
              cursor-in-non-selected-windows nil
              highlight-nonselected-windows nil
              frame-inhibit-implied-resize t
              inhibit-compacting-font-caches nil)

(setq preferred-gc-threshold 16000000)

;; reset it to 16 MB after with the file-name-handler-alist
(defun optimization/normalize ()
	(setq-default gc-cons-threshold preferred-gc-threshold
		            gc-cons-percentage 0.1))

(add-hook 'window-setup-hook #'optimization/normalize)

(unless (or (daemonp) noninteractive)
  (let ((temp-file-name-handler-alist file-name-handler-alist))
    (setq-default file-name-handler-alist nil)
    (defun reset-file-handler-alist-h ()
      (setq file-name-handler-alist
            (delete-dups (append file-name-handler-alist
                                 temp-file-name-handler-alist))))
    (add-hook 'emacs-startup-hook #'reset-file-handler-alist-h)))

;; Fundamental Mode is the simplest mode
(setq initial-major-mode 'fundamental-mode)
(defalias 'yes-or-no-p 'y-or-n-p)

;; Use the Garbage Collector Magic Hack
(elpaca-leaf gcmh
  :hook
  ((window-setup-hook . gcmh-mode)
   (focus-out-hook . gcmh-idle-garbage-collect))
  :custom
  (gcmh-verbose . nil)
  (gcmh-idle-delay . 6)
  (gcmh-high-cons-threshold . preferred-gc-threshold))

;; Show only errors, not warnings
(setq-default warning-minimum-level :error)

(provide 'optimizations)
