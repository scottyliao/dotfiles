;;; init-completion.el --- Minibuffer and in-buffer completion -*- lexical-binding: t; -*-

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

(provide 'init-completion)
;;; init-completion.el ends here
