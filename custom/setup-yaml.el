(use-package yaml-mode
  :ensure t
  :mode (("\\.yaml\\'" . yaml-mode)
	 ("\\.yml\\'" . yaml-mode))
  :config
  (add-hook 'yaml-mode-hook 'highlight-indent-guides-mode))

(provide 'setup-yaml)
