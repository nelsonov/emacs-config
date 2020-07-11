(defun get-mdcommand ()
  "Look for an markdown processor, in order:
pandoc, multimarkdown, markdown or return nil"
  (cond
   ((executable-find "pandoc") "pandoc")
   ((executable-find "multimarkdown") "multimarkdown")
   ((executable-find "markdown") "markdown")))

(setq mdcommand (get-mdcommand))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command mdcommand))

;; Needed by markdown-preview-mode
(use-package websocket
  :ensure t
  :if (boundp 'mdcommand))

;; Needed by markdown-preview-mode
(use-package web-server
  :ensure t
  :if (boundp 'mdcommand))

;; https://github.com/ancane/markdown-preview-mode
;; Only if a markdown processor is found will
;; markdown-preview-mode be loaded
(use-package markdown-preview-mode
  :ensure t
  :if (boundp 'mdcommand)
  :init
  (setq markdown-preview-auto-open nil)
  :custom
  (markdown-preview-ws-port 9010)
  (markdown-preview-host "100.115.92.200")
  (markdown-preview-http-host "100.115.92.200"))

(provide 'setup-markdown)



