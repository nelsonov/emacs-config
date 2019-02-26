(use-package magit
  :ensure t
  :mode ("/\\(\\(\\(COMMIT\\|NOTES\\|PULLREQ\\|TAG\\)_EDIT\\|MERGE_\\|\\)MSG\\|\\(BRANCH\\|EDIT\\)_DESCRIPTION\\)\\'" . git-commit-mode)
  :bind ("C-x M-g" . magit-dispatch-popup)
  :bind ("C-x g" . magit-status))

(use-package gitconfig-mode
  :ensure t
  :mode ("/\\.gitconfig\\'" "/\\.git/config\\'" "/git/config\\'"
         "/\\.gitmodules\\'"))

(use-package gitignore-mode
  :ensure t
  :mode ("/\\.gitignore\\'" "/\\.gitignore_global" "/\\.git/info/exclude\\'"
	 "/git/ignore\\'"))

(use-package gh
  :config
  (use-package pcache :ensure t)
  (use-package logito :ensure t)
  :ensure t)

(use-package gist :ensure t)

(provide 'setup-git)
