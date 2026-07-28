;;; init.el --- Basic personal configuration -*- lexical-binding: t; -*-

;;; Package management

(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;;; Restore GC threshold lowered in early-init.el

(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 32 1024 1024))))

;;; Encoding

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)

;;; UI

(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(setq use-dialog-box nil)
(setq ring-bell-function 'ignore)
(column-number-mode 1)
(global-display-line-numbers-mode 1)
(show-paren-mode 1)
(electric-pair-mode 1)

;;; Sane editing defaults

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq require-final-newline t)
(delete-selection-mode 1)
(global-auto-revert-mode 1)
(setq confirm-kill-emacs #'y-or-n-p)

;; Keep backup/auto-save files out of the working directory.
(let ((backup-dir (expand-file-name "backups" user-emacs-directory))
      (autosave-dir (expand-file-name "autosaves" user-emacs-directory)))
  (make-directory backup-dir t)
  (make-directory autosave-dir t)
  (setq backup-directory-alist `(("." . ,backup-dir))
        auto-save-file-name-transforms `((".*" ,autosave-dir t))
        backup-by-copying t
        version-control t
        delete-old-versions t
        kept-new-versions 5
        kept-old-versions 2))

;; Remember history across sessions.
(use-package savehist
  :init (savehist-mode 1))

(use-package recentf
  :init (recentf-mode 1)
  :custom (recentf-max-saved-items 200))

(use-package saveplace
  :init (save-place-mode 1))

;;; Quality of life packages

(use-package which-key
  :init (which-key-mode 1))

(use-package vertico
  :init (vertico-mode 1))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package marginalia
  :init (marginalia-mode 1))

(use-package consult
  :bind (("C-s" . consult-line)
         ("C-x b" . consult-buffer)))

;;; In-buffer completion (pairs with the minibuffer stack above)

(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.2)
  (corfu-auto-prefix 2)
  (corfu-cycle t)
  :init
  (global-corfu-mode 1))

;;; LSP client (built into Emacs 29+; requires a language server on PATH)

(use-package eglot
  :ensure nil
  :hook ((python-mode . eglot-ensure)
         (js-mode . eglot-ensure)
         (c-mode . eglot-ensure)
         (c++-mode . eglot-ensure))
  :custom
  (eglot-autoshutdown t))

;;; Project management (built into Emacs)

(use-package project
  :ensure nil
  :bind ("C-x p b" . consult-project-buffer))

;;; Version control

(use-package magit
  :bind ("C-x g" . magit-status))

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
