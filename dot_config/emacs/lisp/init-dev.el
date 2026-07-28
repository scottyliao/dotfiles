;;; init-dev.el --- LSP, project management, version control -*- lexical-binding: t; -*-

;; LSP client (built into Emacs 29+; requires a language server on PATH)
(use-package eglot
  :ensure nil
  :hook ((python-mode . eglot-ensure)
         (js-mode . eglot-ensure)
         (c-mode . eglot-ensure)
         (c++-mode . eglot-ensure))
  :custom
  (eglot-autoshutdown t))

;; Project management (built into Emacs)
(use-package project
  :ensure nil
  :bind ("C-x p b" . consult-project-buffer))

;; Version control
(use-package magit
  :bind ("C-x g" . magit-status))

;; File tree sidebar
(use-package treemacs
  :bind ("C-x t t" . treemacs))

(provide 'init-dev)
;;; init-dev.el ends here
