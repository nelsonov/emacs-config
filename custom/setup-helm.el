(use-package helm
  :ensure t)

;; Much of this comes from http://tuhdo.github.io/helm-intro.html

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
;; (global-set-key (kbd "C-c h") 'helm-command-prefix)
;;(global-unset-key (kbd "C-x c"))

;; replace standard M-x with helm version - can be annoying
(global-set-key (kbd "M-x") 'helm-M-x)


(global-set-key (kbd "M-y") 'helm-show-kill-ring)

;; Replace standard C-x C-f - can be annoying and slow in TRAMP
;;(global-set-key (kbd "C-x C-f") 'helm-find-files)

(global-set-key (kbd "C-x b") 'helm-mini)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)


;;rebind tab to run persistent action
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)

;;make TAB work in terminal
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)

;;list actions using C-z
(define-key helm-map (kbd "C-z")  'helm-select-action)

(setq helm-split-window-in-side-p           t   ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t   ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t   ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8   ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)
(helm-autoresize-mode 1)

(helm-mode 1)

(provide 'setup-helm)
