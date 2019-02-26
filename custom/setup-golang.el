(use-package go-mode
  :ensure t
  :mode ("\\.go\\'" . go-mode))

(use-package go-eldoc
  :ensure t
  :after (go-mode)
  :hook (go-mode . go-eldoc-setup))

(defun my-go-mode-setup ()
  (add-hook 'before-save-hook 'gofmt-before-save nil t))

(add-hook 'go-mode-hook 'my-go-mode-setup)

;; https://github.com/nsf/gocode/tree/master/emacs-company

(use-package company-go
  :ensure t)

(provide 'setup-golang)
