;;; search-ivy.el --- Search engine for love and life -*- lexical-binding: t; -*-
;;; Commentary:
;; Ivy is lighter than helm
;;; Code:
(use-package ivy
  :init (ivy-mode +1)
  :custom (ivy-use-virtual-buffers t)
  :config (setq enable-recursive-minibuffers t))

(use-package counsel
  :after ivy
  :config (counsel-mode +1)
  (setq-default ivy-initial-inputs-alist nil))

(use-package ivy-prescient
  :after (ivy counsel)
  :config (ivy-prescient-mode +1))

(use-package swiper
  :if (feature-p! +swiper)
  :after ivy
  :bind ("C-s" . swiper))

(use-package ivy-rich
  :after (ivy counsel)
  :custom (ivy-rich-parse-remote-buffer nil)
  :config
  (ivy-rich-mode +1)
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line))
;;; search-ivy.el ends here
