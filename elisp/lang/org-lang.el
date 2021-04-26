(require 'subr-x)
(use-package git)

(defun org-git-version ()
  "The Git version of `org-mode'.
Inserted by installing `org-mode' or when a release is made."
  (require 'git)
  (let ((git-repo (expand-file-name
                   "straight/repos/org/" user-emacs-directory)))
    (string-trim
     (git-run "describe"
              "--match=release\*"
              "--abbrev=6"
              "HEAD"))))

(defun org-release ()
  "The release version of `org-mode'.
Inserted by installing `org-mode' or when a release is made."
  (require 'git)
  (let ((git-repo (expand-file-name
                   "straight/repos/org/" user-emacs-directory)))
    (string-trim
     (string-remove-prefix
      "release_"
      (git-run "describe"
               "--match=release\*"
               "--abbrev=0"
               "HEAD")))))

(provide 'org-version)

(use-package org
  :straight
  org-plus-contrib
  :custom
  (org-hide-emphasis-markers t)
  (org-hide-block-startup t)
  (org-hide-leading-stars t)
  (org-hide-macro-markers t))

(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :height 1.8))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.6))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.4))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.2))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.0)))))

(use-package mixed-pitch
  :hook
  (org-mode . mixed-pitch-mode))

(use-package toc-org
  :after org
  :hook
  (org-mode . toc-org-mode))

(provide 'org-lang)
