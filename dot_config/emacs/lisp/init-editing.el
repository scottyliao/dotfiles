;;; init-editing.el --- Sane editing defaults -*- lexical-binding: t; -*-

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

(provide 'init-editing)
;;; init-editing.el ends here
