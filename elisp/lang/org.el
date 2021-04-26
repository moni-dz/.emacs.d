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
  org-plus-contrib)

(use-package mixed-pitch
  :hook
  (org-mode . mixed-pitch-mode))

(use-package org-superstar
  :after org
  :custom
  (org-superstar-headline-bullets-list '("◉" "○" "✸" "✿" "✤" "✜" "◆" "▶"))
  (org-superstar-prettify-item-bullets t))

(use-package toc-org :after org)

(provide 'org-lang)
