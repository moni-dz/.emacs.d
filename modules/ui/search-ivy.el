;;; search-ivy.el --- Search engine for love and life -*- lexical-binding: t; -*-
;;; Commentary:
;; Ivy is lighter than helm
;;; Code:
(use-package ivy
  :demand t
  :bind ([remap switch-to-buffer] . ivy-switch-buffer)
  (:map ivy-minibuffer-map
        ("RET" . ivy-alt-done)
        ("C-RET" . ivy-done))
  :custom
  (ivy-use-virtual-buffers t)
  (ivy-count-format "%d/%d ")
  (ivy-height 20)
  (ivy-display-style 'fancy)
  (ivy-wrap t)
  (ivy-action-wrap t)
  (ivy-re-builders-alist
   '((t . ivy--regex-plus)))
  :config (ivy-mode +1))

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
