;;; modules.el --- User-defined features -*- lexical-binding: t; -*-
;;; Commentary:
;; This is where the user defines what features to enable
;;; Code:
(load! :theme monokai-pro
       :editor
       (parens +rainbow)
       indent
       delete
       project
       evil
       :misc
       path
       discordrp
       :ui
       icons
       (search-ivy +swiper)
       discoverability
       tabs
       hl-todo
       :lang
       autocomplete
       checker
       lsp
       rust
       golang
       org
       :tools
       gcmh
       magit
       esup)
;;; modules.el ends here
