(use-package elpy
  :ensure t
  :defer t
  :init
  (elpy-enable)
  (advice-add 'python-mode :before ''elpy-enable))

(when (load "flycheck" t t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))


(defun test-python (module)
  "Test if a python3 module is installed"
  (let* (
	 (teststr (format "import %s" module))
	 (exitcode (car(process-exit-code-and-output "python3" "-c" teststr))))
    (if (equal exitcode 0) 't 'nill)
    ))

;;(test-python "black")

;; sudo pip3 install blacken
(if (equal (test-python "black") t)
    (use-package blacken
      :ensure t)
  (if (equal (test-python "autopep8") t)
      (use-package py-autopep8
	:ensure t
	:init
	(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save))))

;; sudo pip3 install isort
;; => (0 "-r-w-r-- 1 ...")
(if (equal (test-python "py-isort") t)
    (use-package isort
      :ensure t))



(provide 'setup-python)

