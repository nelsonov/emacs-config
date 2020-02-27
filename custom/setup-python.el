(use-package elpy
  :ensure t
  :defer t
  :init
  (elpy-enable)
  (advice-add 'python-mode :before ''elpy-enable))

(when (load "flycheck" t t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; sudo pip3 install autopep8
(use-package py-autopep8
  :ensure t
  :init
  (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save))

;; sudo pip3 install isort
(use-package isort
  :ensure t)

(provide 'setup-python)

