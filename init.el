;; use emacsclient -n to send file to server
(server-start)

;;;;;;;;;; Initialze ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Add melpa to known package repositories
(require 'package)
(package-initialize)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

; Install use-package if not already installed
(if (not (package-installed-p 'use-package))
    (progn
      (package-refresh-contents)
      (package-install 'use-package)))

(eval-when-compile
  (require 'use-package))

(add-to-list 'load-path "~/.emacs.d/custom")
(require 'setup-key)
(require 'setup-utf8)
;;;; End Initialize ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;; Appearence ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Themes ;;;
(setq custom-safe-themes t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;(load-theme 'dichromacy t)
;(load-theme 'dracula t) ;https://draculatheme.com/emacs/
;(load-theme 'distinguished t) ;https://github.com/Lokaltog/distinguished-theme
(load-theme 'ample-zen) ;https://github.com/mjwall/ample-zen
;(load-theme 'moe-dark) ;https://github.com/kuanyui/moe-theme.el
;;; End Themes ;;;

(global-font-lock-mode t) ;Turn on font-lock mode for Emacs
(setq-default transient-mark-mode t) ;Visual feedback on selections
;;(setq require-final-newline t) ;Always end a file with a newline
(setq next-line-add-newlines nil) ;Stop at the end of file, not add lines
;;(setq make-backup-files nil) ;don't make backup files, please
(setq inhibit-startup-message t) ;don't display splash screen

;; show unncessary whitespace that can mess up diff
(add-hook 'prog-mode-hook
          (lambda () (interactive)
            (setq show-trailing-whitespace 1)))

(use-package dtrt-indent
  :ensure t)

(use-package indent-guide
  :ensure t)

(use-package highlight-symbol
  :ensure t
  :bind ("C-c h" . highlight-symbol))

;; https://github.com/abo-abo/ace-window
(use-package ace-window
  :ensure t
  :config
  (global-set-key (kbd "M-o") 'ace-window)
  (setq aw-background t) ;; Grey-out windows while switching
  (setq aw-scope 'global) ;; scope can be 'global' or 'frame'
  (setq aw-dispatch-always t)) ;; always call aw, even if only 2 windows

(require 'setup-ibuffer)
(require 'setup-dired-sidebar)
;;;; End Appearence ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; Editing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun undo-all ()
  "Undo all changes.
This is equivalent to revert-buffer, except that it doesn't
re-read the file.  Useful when editing a remote file."
  (interactive)
  (undo-start)
  (undo-more (length pending-undo-list)))

(defun unfill-region (begin end)
  "Remove all linebreaks in a region but leave paragraphs,
indented text (quotes,code) and lines starting with an
asterix (lists) intact."
  (interactive "r")
  (replace-regexp "\\([^\n]\\)\n\\([^ *\n]\\)" "\\1 \\2" nil begin end))

(use-package string-inflection
  :ensure t
  :bind ("C-c C-u" . my-string-inflection-cycle-auto))

(use-package iedit
  :ensure t)
;;;; End Editing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; Development;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'setup-git)
(require 'setup-ggtags)
(require 'setup-golang)
(require 'setup-projectile)

(use-package yaml-mode
  :ensure t
  :mode ("\\.yaml\\'" . yaml-mode))

(use-package dockerfile-mode
  :ensure t
  :mode ("Dockerfile\\'" . dockerfile-mode))
;;;; End Development ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; Completion ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'setup-company)

(use-package helm
  :ensure t)
;;;; End Completion ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; Custom ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(org-agenda-files (quote ("~/org/notes.org")))
 '(package-selected-packages
   (quote
    (company-go go-eldoc company ace-window helm projectile pandoc-mode org-protocol-capture-html org-protocol highlight-symbol ggtags dockerfile-mode yaml-mode use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
