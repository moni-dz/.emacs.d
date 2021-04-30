;;; -*- lexical-binding: t -*-

;; init time profiler
(use-package esup)

;; dired
(use-package diredfl
  :hook (dired-mode . diredfl-global-mode)
  :config
  (custom-theme-set-faces
   'user
   '(diredfl-dir-heading ((t (:inherit variable-pitch :height 2.0))))))

;; git client
(use-package magit
  :commands magit
  :custom
  (magit-section-visibility-indicator nil))

;; Some tricks had to be done in order for this to work with `doom-modeline'
(use-package keycast
  :config
  (define-minor-mode keycast-mode
    "Show current command and its keybinding in the modeline."
    :global t
    (if keycast-mode
        (add-hook 'pre-command-hook 'keycast--update t)
      (remove-hook 'pre-command-hook 'keycast--update)))

  (add-to-list 'global-mode-string '("" mode-line-keycast)))

(use-package elfeed
  :bind
  ("C-x w" . elfeed)
  :hook
  (((elfeed-search-mode elfeed-show-mode) . centaur-tabs-local-mode)
   (elfeed-search-mode . elfeed-update)
   (elfeed-show-mode . interface/toggle-zen-mode))
  :config
  (custom-theme-set-faces
   'user
   '(message-header-subject ((t (:inherit variable-pitch :height 2.0))))
   '(message-header-to ((t (:inherit variable-pitch :height 1.2))))
   '(message-header-other ((t (:inherit variable-pitch)))))
  :custom
  (elfeed-feeds
   '(("https://repology.org/maintainer/lythe1107%40gmail.com/feed-for-repo/nix_unstable/atom" nixos nixpkgs)
     ("https://weekly.nixos.org/feeds/all.rss.xml" nixos)
     ("https://github.com/polybar/polybar/releases.atom" releases)
     ("https://github.com/xanmod/linux/releases.atom" releases)
     ("https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/releases.atom" releases)
     ("https://github.com/Misterio77/flavours/releases.atom" releases)
     ("https://github.com/zigtools/zls/releases.atom" releases)
     ("https://github.com/NerdyPepper/curie/releases.atom" releases)
     ("https://github.com/NerdyPepper/scientifica/releases.atom" releases)
     ("https://github.com/desbma/sacad/releases.atom" releases)
     ("https://github.com/desbma/web-cache/releases.atom" releases)
     ("https://github.com/curlpipe/ox/releases.atom" releases)
     ("https://github.com/ogham/exa/releases.atom" releases)
     ("https://github.com/DelusionalLogic/neocomp/releases.atom" releases))))

(provide 'tools)
