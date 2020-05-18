;;; core-lib.el --- Core module that defines utility functions and macros -*- lexical-binding: t -*-
;;; Commentary:
;; Defines functions and macros used throughout the configuration
;;; Code:

(require 'cl-lib)
(use-package dash)
(use-package dash-functional)
(use-package f)

(defmacro load! (&rest modules)
  "Load the MODULES."
  `(f2k--load-modules ',modules))

(defmacro with-feature! (feature &rest body)
  "Execute BODY if FEATURE is activated."
  (declare (indent 1))
  `(when (f2k--feature-activated-p (f2k--current-category) (f2k--current-module) ',feature)
     ,@body))

(defmacro with-os! (os &rest body)
  "Execute BODY if current os is OS."
  (declare (indent 1))
  `(when (if (consp ',os) (memq system-type ',os) (eq system-type ',os))
     ,@body))

(defmacro feature-p! (feature)
  "Return nil if the FEATURE is not activated in the current category and module, t otherwise."
  `(f2k--feature-activated-p (f2k--current-category) (f2k--current-module) ',feature))

(defmacro module-p! (category module)
  "Return nil if the MODULE is not activated in the right CATEGORY, t otherwise."
  `(f2k--module-activated-p ',category ',module))

(defun f2k--features (category module)
  "Return the features given a CATEGORY and MODULE by looking in `f2k--modules'."
  (->> f2k--modules
       (--filter (and (-> it car (eq category)) (-> it cadr (eq module))))
       cddar))

(defun f2k--feature-activated-p (category module feature)
  "Return nil if the FEATURE is not activated in the right CATEGORY and MODULE, t otherwise."
  (memq feature (f2k--features category module)))

(defun f2k--modules (category)
  "Return the modules given a CATEGORY by looking in `f2k--modules'."
  (->> f2k--modules
       (--filter (eq (car it) category))
       (-map #'cadr)))

(defun f2k--module-activated-p (category module)
  "Return nil if the MODULE is not activated in the right CATEGORY, t otherwise."
  (memq module (f2k--modules category)))

(defun f2k--current-module ()
  "Return the current module."
  (when (string-prefix-p f2k-modules-dir load-file-name)
    (-> load-file-name file-name-sans-extension f-split last car intern)))

(defun f2k--categories ()
  "Return the categories by looking in `f2k-modules'."
  (->> f2k--modules (-map #'car) delete-dups))

(defun f2k--current-category ()
  "Return the current category."
  (when (string-prefix-p f2k-modules-dir load-file-name)
    (cl-flet ((add-prefix (string prefix) (concat prefix string)))
      (-> load-file-name f-split (last 2) car (add-prefix ":") intern))))

(defun f2k--hierarchical-cons-to-pairs (predicate list default)
  "Return a list of pairs based on LIST where the left element is the last element which satisfies PREDICATE."
  (cond ((null list) nil)
        ((funcall predicate (car list))
         (f2k--hierarchical-cons-to-pairs predicate (cdr list)
                                              (car list)))
        ((consp (car list))
         (cons `(,default . ,(car list))
               (f2k--hierarchical-cons-to-pairs predicate (cdr list) default)))
        (t (cons `(,default . (,(car list)))
                 (f2k--hierarchical-cons-to-pairs predicate (cdr list) default)))))

(defun f2k--load-modules (modules)
  "Load the MODULES, internals of `load!'."
  (dolist (pair (f2k--hierarchical-cons-to-pairs 'keywordp modules :.))
    (add-to-list 'f2k--modules pair t))
  (mapcar #'f2k--load-pair f2k--modules))

(defun f2k--load-pair (pair)
  "Convert a PAIR (:category . '(module features?)) to a string \"category/module\"."
  (pcase-let ((`(,category . ,module) pair))
    (-> category
        symbol-name
        (substring 1)
        (concat "/" (symbol-name (car module)))
        f2k--load-module)))

(defun f2k--load-module (module-name)
  "Load MODULE-NAME by looking in `f2k-modules-dir'."
  (interactive "Enter path to module starting from module directory: ")
  (load (expand-file-name module-name f2k-modules-dir)))

(provide 'core-lib)
;;; core-lib.el ends here
