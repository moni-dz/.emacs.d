;;; -*- lexical-binding: t; -*-

(elpaca-leaf general
  :after evil
  :require t
  :config

  (general-create-definer leader :prefix "SPC")
  (general-create-definer local-leader :prefix "SPC p")

  (leader '(normal visual)
    "o" #'find-file
    "z" #'zen-mode
    "Z" #'focus-mode
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

  (leader 'normal org-mode-map
    "." #'org-present-next
    "," #'org-present-prev)

  (local-leader 'normal org-mode-map
    "p" #'org-present
    "P" #'org-present-quit
    "." #'org-present-end
    "," #'org-present-beginning)

  (local-leader 'normal lsp-bridge-mode-map
    "d" #'lsp-bridge-diagnostic-list)
  
  (local-leader 'normal ess-r-mode-map
    "e" #'ess-eval-buffer
    "l" #'ess-eval-line
    "s" #'string-inflection-python-style-cycle)

  (local-leader 'normal rust-mode-map
    "r" #'rust-run
    "f" #'rust-format-buffer
    "b" #'rust-compile
    "s" #'string-inflection-ruby-style-cycle)

  (local-leader 'normal zig-mode-map
    "r" #'zig-run
    "f" #'zig-format-buffer
    "b" #'zig-compile
    "t" #'zig-test-buffer))

(provide 'keybindings)
