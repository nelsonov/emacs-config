(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq ibuffer-saved-filter-groups
      '(("default"
	 ("emacs-config" (or (filename . ".emacs.d")
			     (filename . "emacs-config")))
	 ("Org" (or (mode . org-mode)
		    (filename . "OrgMode")))
	 ("emacs" (or
		   (name . "^\\*scratch\\*$")
		   (name . "^\\*Messages\\*$")))
	 ("Magit" (name . "\*magit"))
	 ("Help" (or (name . "\*Help\*")
		     (name . "\*Apropos\*")
		     (name . "\*info\*"))))))
(add-hook 'ibuffer-mode-hook
	  '(lambda ()
	     (ibuffer-auto-mode 1)
	     (ibuffer-switch-to-saved-filter-groups "default")))
(setq ibuffer-expert t)
(setq ibuffer-show-empty-filter-groups nil)

;Not Working
;(defadvice ibuffer-update-title-and-summary (after remove-column-titles)
;  (with-current-buffer
;    (inhibit-read-only t)
;    (goto-char 1)
;    (search-forward "-\n" nil t)
;    (delete-region 1 (point))
;    (let ((window-min-height 1))
;      ;; save a little screen estate
;      (shrink-window-if-larger-than-buffer))
;    (inhibit-read-only t)))
;(ad-activate 'ibuffer-update-title-and-summary)

(defun ibuffer-vc-set-filter-groups-cycle ()
  (interactive)
  (if (get 'ibuffer-vc-set-filter-groups-cycle 'state)
      (progn
	(ibuffer-switch-to-saved-filter-groups "default")
	(put 'ibuffer-vc-set-filter-groups-cycle 'state nil))
    (progn
      (ibuffer-vc-set-filter-groups-by-vc-root)
      (put 'ibuffer-vc-set-filter-groups-cycle 'state t))))


(use-package ibuffer-vc
  :ensure t
  :bind ("C-x C-v" . ibuffer-vc-set-filter-groups-cycle))

(defun sidebar-toggle ()
  "Toggle both `dired-sidebar' and `ibuffer-sidebar'."
  (interactive)
  (dired-sidebar-toggle-sidebar)
  (ibuffer-sidebar-toggle-sidebar))

(use-package ibuffer-sidebar
  :bind ("C-c s i" . ibuffer-sidebar-toggle-sidebar)
  :bind ("C-c s b" . sidebar-toggle)
  :ensure t
  :commands (ibuffer-sidebar-toggle-sidebar))
;  :config
;  (setq ibuffer-sidebar-use-custom-font t)
;  (setq ibuffer-sidebar-face `(:family "Helvetica" :height 140)))

(provide 'setup-ibuffer)
