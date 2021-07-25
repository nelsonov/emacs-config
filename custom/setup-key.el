;; See also:
;; setup-helm.el
;; setup-ibuffer.el
;; setup-org.el
;; setup-spelling.el
;; setup-utf8.el
;;
(global-set-key (kbd "C-?") `help-command)
(global-set-key (kbd "M-?") `mark-paragraph)
(global-set-key (kbd "C-h") `delete-backward-char)
(global-set-key (kbd "M-h") `backward-kill-word)
(global-set-key (kbd "C-c g") 'goto-line)
(global-set-key (kbd "C-c r") 'replace-string)
(global-set-key (kbd "C-c x") 'replace-regex)
(global-set-key [f9]    'goto-line); F9
(global-set-key (kbd "RET") 'newline-and-indent)
;(global-set-key (kbd "C-c c") 'compile) ; conflicts with org-mode bindings
(provide 'setup-key)

