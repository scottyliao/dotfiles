;;; init-dashboard.el --- Startup dashboard -*- lexical-binding: t; -*-

(use-package nerd-icons
  :custom
  (nerd-icons-font-family "JetBrainsMono NF"))

(use-package dashboard
  :init
  (setq dashboard-startup-banner 'logo
        dashboard-center-content t
        dashboard-vertically-center-content t
        dashboard-set-heading-icons t
        dashboard-set-file-icons t
        dashboard-icon-type 'nerd-icons
        dashboard-items '((recents . 5)
                           (bookmarks . 5)
                           (projects . 5)))
  :config
  (dashboard-setup-startup-hook))

(provide 'init-dashboard)
;;; init-dashboard.el ends here
