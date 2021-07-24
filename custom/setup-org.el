
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Create the file ~/.local/share/applications/org-protocol.desktop containing:
;;
;;[Desktop Entry]
;;Name=org-protocol
;;Exec=emacsclient %u
;;Type=Application
;;Terminal=false
;;Categories=System;
;;MimeType=x-scheme-handler/org-protocol;
;;
;;Note: Each line’s key must be capitalized exactly as
;;displayed, or it will be an invalid .desktop file.
;;
;;Then update ~/.local/share/applications/mimeinfo.cache by running:
;;
;;On KDE: kbuildsycoca4
;;On GNOME: update-desktop-database ~/.local/share/applications/
;;On LXDE (as root): update-desktop-database
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c b") 'org-switchb)

;(setq org-archive-location
;      '("~/org/archive.org"))

(use-package s
  :ensure t)

(use-package pandoc-mode
  :ensure t)

(require 'org-protocol)

;; (setq org-capture-templates
;;       '(("w" "Web site"
;;        entry (file+olp "~/org/inbox.org" "Web")
;;        "* %c :website:\n%U %?%:initial")))

(setq org-capture-templates
      '(("w" "Web site" entry
       (file "")
       "* %a :website:\n\n%U %?\n\n%:initial")))

;(require 'org-protocol-capture-html)

;(require 'org-eww)
(csetq org-id-link-to-org-use-id 'use-existing)


(provide 'setup-org)

