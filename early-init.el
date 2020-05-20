;;; early-init.el --- The earliest init file to load -*- lexical-binding: t; no-byte-compile: t; -*-
;;; Commentary:
;; We try to do optimizations as early as possible here
;;; Code:
(setq-default load-prefer-newer t)

;; Set Emacs minimum version to 28
(defconst f2k-required-version "28")
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
;;; early-init.el ends here
