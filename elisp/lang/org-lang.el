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
  :hook
  ((org-mode . org-mode-remove-stars)
   (org-mode . visual-line-mode)
   (org-mode . org-indent-mode))
  :custom
  (org-hide-emphasis-markers t)
  (org-hide-block-startup t)
  (org-hide-leading-stars t)
  (org-hide-macro-markers t))

(custom-set-faces
 '(org-document-title ((t (:inherit outline-1 :height 3.0))))
 '(org-document-info ((t (:inherit outline-3 :height 1.5))))
 '(org-level-1 ((t (:inherit outline-1 :height 2.0))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.8))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.4))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.2))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.0)))))

(font-lock-add-keywords
 'org-mode
 '(("^ *\\([\*]\\) "
    (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(use-package mixed-pitch
  :hook
  (org-mode . mixed-pitch-mode))

(use-package toc-org
  :after org
  :hook
  (org-mode . toc-org-mode))

(defun org-mode-remove-stars ()
  (font-lock-add-keywords
   nil
   '(("^\\*+ "
      (0
       (prog1 nil
         (put-text-property
          (match-beginning 0) (match-end 0)
          'invisible t)))))))

(provide 'org-lang)
