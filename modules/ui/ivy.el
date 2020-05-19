;;; ivy.el --- Search engine for love and life -*- lexical-binding: t; -*-
;;; Commentary:
;; Ivy is lighter than helm
;;; Code:
(setq enable-recursive-minibuffers t)

(use-package ivy
  :hook (after-init . ivy-mode)
  :custom (ivy-use-virtual-buffers t))

(use-package counsel
  :after ivy
  :init (counsel-mode 1))

(use-package ivy-rich
  :after (ivy counsel)
  :config
  (ivy-rich-mode 1)
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line))

(use-package all-the-icons-ivy-rich
  :after ivy-rich
  :init (all-the-icons-ivy-rich-mode 1))

(use-package swiper
  :if (feature-p! +swiper)
  :after ivy
  :bind ("C-s" . swiper))

(use-package ivy-prescient
  :if (feature-p! +prescient)
  :after ivy
  :init (ivy-prescient-mode 1)
  :custom (prescient-save-file (concat f2k-dir "cache/prescient-save.el"))
  :config (prescient-persist-mode 1))
;;; ivy.el ends here
