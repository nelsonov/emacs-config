(use-package jinja2-mode
  :ensure t
  :mode (("\\.jinja\\'" . jinja2-mode)
	 ("\\.jinja2\\'" . jinja2-mode)
	 ("\\.j2\\'" . jinja2-mode)))

(provide 'setup-jinja2)
