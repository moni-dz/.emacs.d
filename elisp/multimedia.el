(use-package emms
  :defer t
  :config
  (require 'emms-setup)
  (require 'emms-volume)
  (require 'emms-player-mpd)
  (emms-all)
  (add-to-list 'emms-info-functions 'emms-info-mpd)
  (add-to-list 'emms-player-list 'emms-player-mpd)
  :custom
  (emms-player-mpd-server-name "localhost")
  (emms-player-mpd-server-port "6600")
  (emms-player-mpd-music-directory "~/Media/Music")
  (emms-volume-change-function 'emms-volume-mpd-change))

(provide 'multimedia)
