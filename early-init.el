(setq gc-cons-threshold most-positive-fixnum)

(tooltip-mode -1)

;; Early frame modifications
(add-to-list 'default-frame-alist '(menu-bar-lines . 0))
(add-to-list 'default-frame-alist '(tool-bar-lines . 0))
(add-to-list 'default-frame-alist '(vertical-scroll-bars))

;; start the initial frame maximized
;;(add-to-list 'initial-frame-alist '(maximized))

;; start every frame maximized
;;(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; HACK Work around native compilation on macOS failing with 'ld: library not
;; found for -lemutls_w'.
;; https://github.com/d12frosted/homebrew-emacs-plus/issues/554
(if (eq system-type 'darwin)
  (setenv "LIBRARY_PATH" "/opt/homebrew/opt/gcc/lib/gcc/13:/opt/homebrew/opt/libgccjit/lib/gcc/13:/opt/homebrew/opt/gcc/lib/gcc/13/gcc/aarch64-apple-darwin22/13"))

(setq-default use-dialog-box nil
              custom-file (if (memq system-type '(gnu/linux darwin)) "/dev/null" "NUL")
              frame-inhibit-implied-resize t
              ring-bell-function 'ignore
              visible-bell nil
              uniquify-buffer-name-style 'post-forward-angle-brackets
              inhibit-startup-screen t
              inhibit-startup-message t
              inhibit-startup-echo-area-message t
              initial-scratch-message nil
              package-enable-at-startup nil
              vc-handled-backends nil
              fringes-outside-margins t)

(defvar elpaca-installer-version 0.4)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/"
                                                 elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil
                              :files (:defaults (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (< emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                 ((zerop (call-process "git" nil buffer t "clone"
                                       (plist-get order :repo) repo)))
                 ((zerop (call-process "git" nil buffer t "checkout"
                                       (or (plist-get order :ref) "--"))))
                 (emacs (concat invocation-directory invocation-name))
                 ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                       "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                 ((require 'elpaca))
                 ((elpaca-generate-autoloads "elpaca" repo)))
            (kill-buffer buffer)
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

(elpaca leaf)
(elpaca-wait)

;;;###autoload
(defmacro elpaca-leaf (order &rest body)
  "Execute BODY in `leaf' declaration after ORDER is finished.
If the :disabled keyword is present in body, the package is completely ignored.
This happens regardless of the value associated with :disabled.
The expansion is a string indicating the package has been disabled."
  (declare (indent 1))
  (if (memq :disabled body)
      (format "%S :disabled by elpaca-leaf" order)
    (let ((o order))
      (when-let ((ensure (cl-position :ensure body)))
        (setq o (if (null (nth (1+ ensure) body)) nil order)
              body (append (cl-subseq body 0 ensure)
                           (cl-subseq body (+ ensure 2)))))
      `(elpaca ,o (leaf
                    ,(if-let (((memq (car-safe order) '(quote \`)))
                              (feature (flatten-tree order)))
                         (cadr feature)
                       (elpaca--first order))
                    ,@body)))))

(elpaca-leaf no-littering
  :leaf-defer nil
  :require t)

(elpaca-leaf exec-path-from-shell
  :leaf-defer nil
  :init
  (add-hook 'window-setup-hook #'exec-path-from-shell-initialize))

(elpaca-wait)

(add-to-list 'load-path "~/.config/emacs/elisp")
(add-to-list 'load-path "~/.config/emacs/elisp/lang")
