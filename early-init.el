;;; early-init.el --- The earliest init file to load -*- lexical-binding: t; no-byte-compile: t; -*-
;;; Commentary:
;; We try to do optimizations as early as possible here
;;; Code:
(setq-default load-prefer-newer t ;; Load newer byte-compiled files
              inhibit-compacting-font-caches nil ;; Don't compact font caches to help with `org-superstar' performance
              bidi-display-reordering 'left-to-right ;; Disable RTL
              cursor-in-non-selected-windows nil
              highlight-nonselected-windows nil
              create-lockfiles nil ;; just stop ur littering in my folders ffs
              frame-inhibit-implied-resize t
              ;; Set encoding to UTF-8
              locale-coding-system 'utf-8)

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Set Emacs minimum version to 27
(defconst f2k-required-version "27")
(when (version< emacs-version f2k-required-version)
  (error "Required Emacs version is %s, but current version is %s" f2k-required-version emacs-version))

;; Temporarily save the file-name-handler-alist
(defvar f2k--file-name-handler-alist file-name-handler-alist)

;; Remove glimpses of unstyled emacs
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(when (featurep 'ns)
  (push '(ns-transparent-titlebar . t) default-frame-alist))

;; Ignore .Xresources
(advice-add #'x-apply-session-resources :override #'ignore)

;; Avoid any GC pauses at init.
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 2.0
      preferred-gc-threshold 16777216
      file-name-handler-alist nil)

;; and then reset it to 16MiB after with the file-name-handler-alist
(add-hook 'emacs-startup-hook (lambda ()
	                              (setq gc-cons-threshold preferred-gc-threshold
		                                  gc-cons-percentage 0.1)
                                (dolist (handler f2k--file-name-handler-alist)
                                  (add-to-list 'file-name-handler-alist handler))
                                (makunbound 'f2k--file-handler-alist)))
;;; early-init.el ends here
