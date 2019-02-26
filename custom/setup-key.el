(global-set-key (kbd "C-?") `help-command)
(global-set-key (kbd "M-?") `mark-paragraph)
(global-set-key (kbd "C-h") `delete-backward-char)
(global-set-key (kbd "M-h") `backward-kill-word)
(global-set-key (kbd "C-c g") 'goto-line)
(global-set-key [f9]    'goto-line); F9
(global-set-key (kbd "RET") 'newline-and-indent)

(provide 'setup-key)
