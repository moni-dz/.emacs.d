;;; config.el --- User Configuration (think of this as userland) -*- lexical-binding: t; no-byte-compile: t; -*-
;;; Commentary:
;; User configuration tangled from an org file.
;; cool personal stuff
;;; Code:
(defun f2k--tangle-config-on-save-h ()
  "Tangle literate config on save."
  (if (string= (buffer-name) "config.org")
      (org-babel-tangle-file (concat f2k-dir "config.org") (concat f2k-dir "config.el"))))

(add-hook 'after-save-hook #'f2k--tangle-config-on-save-h)

(defconst f2k-private-file (expand-file-name "private.el" f2k-dir))

(progn
  (unless (file-exists-p f2k-private-file)
    (write-region "" nil f2k-private-file))

  (if (file-exists-p f2k-private-file)
      (load (concat f2k-dir "private.el"))))

(set-face-attribute 'default nil
                    :family "FantasqueSansMono Nerd Font"
                    :height 90
                    :weight 'bold
                    :width 'normal)

(set-face-attribute 'variable-pitch nil
                    :family "Inter"
                    :height 90
                    :weight 'normal
                    :width 'normal)

;;; config.el ends here
