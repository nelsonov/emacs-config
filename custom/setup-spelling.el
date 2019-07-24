;;Choose spell checker
;;From:
;;http://blog.binchen.org/posts/what-s-the-best-spell-check-set-up-in-emacs.html
;; if (aspell installed) { use aspell}
;; else if (hunspell installed) { use hunspell }
;; whatever spell checker I use, I always use English dictionary
;; I prefer use aspell because:
;; 1. aspell is older
;; 2. looks Kevin Atkinson still get some road map for aspell:
;; @see http://lists.gnu.org/archive/html/aspell-announce/2011-09/msg00000.html
(defun flyspell-detect-ispell-args (&optional run-together)
  "if RUN-TOGETHER is true, spell check the CamelCase words."
  (let (args)
    (cond
     ((string-match  "aspell$" ispell-program-name)
      ;; Force the English dictionary for aspell
      ;; Support Camel Case spelling check (tested with aspell 0.6)
      (setq args (list "--sug-mode=ultra" "--lang=en_US"))
      (if run-together
          (setq args (append args '("--run-together"))))
      ((string-match "hunspell$" ispell-program-name)
       ;; Force the English dictionary for hunspell
       (setq args "-d en_US")))
     args))

  (cond
   ((executable-find "aspell")
    ;; you may also need `ispell-extra-args'
    (setq ispell-program-name "aspell"))
   ((executable-find "hunspell")
    (setq ispell-program-name "hunspell")

    ;; Please note that `ispell-local-dictionary` itself will be
    ;; passed to hunspell cli with "-d" it's also used as the key to
    ;; lookup ispell-local-dictionary-alist if we use different
    ;; dictionary
    (setq ispell-local-dictionary "en_US")
    (setq ispell-local-dictionary-alist
	  '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8))))
   (t (setq ispell-program-name nil)))

  ;; ispell-cmd-args is useless, it's the list of *extra* arguments we
  ;; will append to the ispell process when "ispell-word" is called.
  ;; ispell-extra-args is the command arguments which will *always* be
  ;; used when start ispell process Please note when you use hunspell,
  ;; ispell-extra-args will NOT be used.  Hack
  ;; ispell-local-dictionary-alist instead.
  (setq-default ispell-extra-args (flyspell-detect-ispell-args t))
  ;; (setq ispell-cmd-args (flyspell-detect-ispell-args))
  (defadvice ispell-word (around my-ispell-word activate)
    (let ((old-ispell-extra-args ispell-extra-args))
      (ispell-kill-ispell t)
      (setq ispell-extra-args (flyspell-detect-ispell-args))
      ad-do-it
      (setq ispell-extra-args old-ispell-extra-args)
      (ispell-kill-ispell t)))

  (defadvice flyspell-auto-correct-word (around my-flyspell-auto-correct-word activate)
    (let ((old-ispell-extra-args ispell-extra-args))
      (ispell-kill-ispell t)
      ;; use emacs original arguments
      (setq ispell-extra-args (flyspell-detect-ispell-args))
      ad-do-it
      ;; restore our own ispell arguments
      (setq ispell-extra-args old-ispell-extra-args)
      (ispell-kill-ispell t)))

  (defun text-mode-hook-setup ()
    ;; Turn off RUN-TOGETHER option when spell check text-mode
    (setq-local ispell-extra-args (flyspell-detect-ispell-args)))
  (add-hook 'text-mode-hook 'text-mode-hook-setup)

;;;;; Flyspell ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Disable printing mesages for every word
;(setq flyspell-issue-message-flag nill)

;;Create terminal-style popup menu for flyspell
(defun flyspell-emacs-popup-textual (event poss word)
  "A textual flyspell popup menu."
  (require 'popup)
  (let* ((corrects (if flyspell-sort-corrections
		       (sort (car (cdr (cdr poss))) 'string<)
		     (car (cdr (cdr poss)))))
	 (cor-menu (if (consp corrects)
		       (mapcar (lambda (correct)
				 (list correct correct))
			       corrects)
		     '()))
	 (affix (car (cdr (cdr (cdr poss)))))
	 show-affix-info
	 (base-menu  (let ((save (if (and (consp affix) show-affix-info)
				     (list
				      (list (concat "Save affix: " (car affix))
					    'save)
				      '("Accept (session)" session)
				      '("Accept (buffer)" buffer))
				   '(("Save word" save)
				     ("Accept (session)" session)
				     ("Accept (buffer)" buffer)))))
		       (if (consp cor-menu)
			   (append cor-menu (cons "" save))
			 save)))
	 (menu (mapcar
		(lambda (arg) (if (consp arg) (car arg) arg))
		base-menu)))
    (cadr (assoc (popup-menu* menu :scroll-bar t) base-menu))))

;Always use flyspell popup, both in GUI and terminal
(eval-after-load "flyspell"
  '(progn
     (fset 'flyspell-emacs-popup 'flyspell-emacs-popup-textual)))

;;Skipping flyspell on specific region. This is useful for code block
;;in org files, but any region with clear delimiters can be skipped
(add-to-list 'ispell-skip-region-alist '("^#+BEGIN_SRC" . "^#+END_SRC")))


(provide 'setup-spelling)

;;Use flyspell popup in terminal, normal menu in GUI
;(defun flyspell-emacs-popup-choose (org-fun event poss word)
;  (if (window-system)
;      (funcall org-fun event poss word)
;    (flyspell-emacs-popup-textual event poss word)))
;(eval-after-load "flyspell"
;  '(progn
;     (advice-add 'flyspell-emacs-popup :around #'flyspell-emacs-popup-choose)))

;;Run flyspell with aspell instead of ispell
;;If you use flyspell with aspell instead of ispell you have to add:
;(setq ispell-list-command "--list")
;
;;Because the “-l” option mean “--lang” in aspell and the “-l”
;;option mean “--list” in ispell. flyspell-buffer, and
;;flyspell-region are affected by this problem.

;;Example change dictionary binding
;      (defun fd-switch-dictionary()
;      (interactive)
;      (let* ((dic ispell-current-dictionary)
;    	 (change (if (string= dic "deutsch8") "english" "deutsch8")))
;        (ispell-change-dictionary change)
;        (message "Dictionary switched from %s to %s" dic change)
;        ))
;(global-set-key (kbd "<f8>")   'fd-switch-dictionary)

;;Another example for changing dictionary
;    (let ((langs '("american" "francais" "brasileiro")))
;      (setq lang-ring (make-ring (length langs)))
;      (dolist (elem langs) (ring-insert lang-ring elem)))
;    (defun cycle-ispell-languages ()
;      (interactive)
;      (let ((lang (ring-ref lang-ring -1)))
;        (ring-insert lang-ring lang)
;        (ispell-change-dictionary lang)))
;    (global-set-key [f6] 'cycle-ispell-languages)
;;;;; End Flyspell ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

