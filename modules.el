;;; modules.el --- User-defined features -*- lexical-binding: t; -*-
;;; Commentary:
;; This is where the user defines what features to enable
;;; Code:
(load! :theme monokai-pro ;; the good monokai
       :editor
       (parens +rainbow) ;; () [] {} autoclose
       aggressive-indent ;; aggressive indentation
       hungry-delete ;; hungry delete
       projectile ;; project management
       evil ;; vim bindings
       :misc
       path ;; inherit shell envronment
       elcord ;; flex your editor to discord
       wakatime ;; track our stats boys
       :ui
       unicode ;; unicode support
       ligatures ;; pretty font ligatures
       icons ;; pretty font icons
       writeroom ;; focus on your code
       (ivy +swiper    ;; the only good completion (except for selectrum but its too early)
            +prescient)
       discoverability ;; show available bindings for keypress
       tabs ;; tabs for active buffers
       hl-todo ;; highlight TODO/HACK/FIXME/NOTE
       :lang
       (company +childframe) ;; autocompletion support
       flycheck ;; syntax checking / linting support
       lsp ;; lsp support
       rust ;; rust support
       golang ;; go support
       org ;; literate
       :tools
       gcmh ;; gc management
       magit ;; git porcelain
       vterm ;; terminal emulator
       esup ;; start-up profiler
       explain-pause ;; another profiler
       ) 
;;; modules.el ends here
