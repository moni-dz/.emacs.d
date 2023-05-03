;;; -*- lexical-binding: t; -*-

(elpaca-leaf general
  :after evil
  :require t
  :config

  (general-create-definer leader :prefix "SPC")
  (general-create-definer local-leader :prefix "SPC p")

  (leader 'normal
    "o" #'find-file
    "z" #'interface/toggle-zen-mode
    "k" #'kill-buffer-and-window
    "K" #'kill-other-buffers
    "q q" #'save-buffers-kill-terminal)

  ;; TODO: move to respective major-mode configuration
  (general-define-key
   :states 'normal :keymaps 'olivetti-mode-map
   "-" #'olivetti-shrink
   "=" #'olivetti-expand)
  
  (leader 'normal emacs-lisp-mode-map
    "h v" #'helpful-variable
    "h f" #'helpful-callable
    "h k" #'helpful-key)

  (local-leader 'normal flymake-mode-map
    "d" #'flymake-show-buffer-diagnostics)
  
  (local-leader 'normal ess-r-mode-map
    "e" #'ess-eval-buffer
    "l" #'ess-eval-line))

(provide 'keybindings)
