;;; -*- lexical-binding: t -*-

;; native compilation
(setq comp-speed 3
      comp-async-report-warnings-errors nil)

;; Temporarily save the file-name-handler-alist
(defvar temp-file-name-handler-alist file-name-handler-alist)

;; Ignore .Xresources
(advice-add #'x-apply-session-resources :override #'ignore)

;; Avoid any GC pauses at init.
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6
      preferred-gc-threshold 16777216)

(setq-default file-name-handler-alist nil
              create-lockfiles nil
              bidi-display-reordering nil
              cursor-in-non-selected-windows nil
              highlight-nonselected-windows nil
              frame-inhibit-implied-resize t
              inhibit-compacting-font-caches nil)

;; and then reset it to 16MiB after with the file-name-handler-alist
(defun optimization/normalize ()
	(setq-default gc-cons-threshold preferred-gc-threshold
		            gc-cons-percentage 0.1)
  (garbage-collect))

(add-hook 'emacs-startup-hook #'optimization/normalize)

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

;; Escape key cancels anything
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Use the Garbage Collector Magic Hack
(pkg! gcmh
  :hook
  ((emacs-startup . gcmh-mode)
   (focus-out . gcmh-idle-garbage-collect))
  :custom
  (gcmh-verbose nil)
  (gcmh-idle-delay 6)
  (gcmh-high-cons-threshold 16777216))

;; Show only errors, not warnings
(setq-default warning-minimum-level :error)

(provide 'optimization)
