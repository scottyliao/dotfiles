;;; init-ui.el --- UI tweaks -*- lexical-binding: t; -*-

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

(provide 'init-ui)
;;; init-ui.el ends here
