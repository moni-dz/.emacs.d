;; Temporarily save the file-name-handler-alist
(defvar f2k--file-name-handler-alist file-name-handler-alist)

;; Ignore .Xresources
(advice-add #'x-apply-session-resources :override #'ignore)

;; Avoid any GC pauses at init.
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6
      preferred-gc-threshold 16777216
      file-name-handler-alist nil)

;; and then reset it to 16MiB after with the file-name-handler-alist
(run-with-idle-timer
 5 nil
 (lambda ()
	 (setq gc-cons-threshold preferred-gc-threshold
		     gc-cons-percentage 0.1)
   (dolist (handler f2k--file-name-handler-alist)
     (add-to-list 'file-name-handler-alist handler))
   (makunbound 'f2k--file-handler-alist)))


(setq initial-major-mode 'fundamental-mode)
(defalias 'yes-or-no-p 'y-or-n-p)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(setq create-lockfiles nil
      inhibit-compacting-font-caches nil
      bidi-display-reordering nil
      cursor-in-non-selected-windows nil
      highlight-nonselected-windows nil
      frame-inhibit-implied-resize t)

;; Use the Garbage Collector Magic Hack
(use-package gcmh
  :init (gcmh-mode +1)
  :hook (focus-out . gcmh-idle-garbage-collect)
  :custom
  (gcmh-verbose nil)
  (gcmh-idle-delay 6)
  (gcmh-high-cons-threshold 16777216))

;; Stop warning me about things that I shouldn't fix
(setq warning-minimum-level :emergency)

(provide 'optimization)
