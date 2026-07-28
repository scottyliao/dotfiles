;;; early-init.el --- Runs before init.el and before the UI is initialized -*- lexical-binding: t; -*-

;; Speed up startup by temporarily raising the GC threshold; restored in init.el.
(setq gc-cons-threshold most-positive-fixnum)

;; package.el will be configured explicitly in init.el.
(setq package-enable-at-startup nil)

;; Avoid the frame resize/flash during startup by disabling these before
;; the first frame is created, then leaving them off in init.el too.
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; Set the initial frame size and font before the first frame is created
;; (setting them later would resize/flash the frame).
(push '(width . 160) default-frame-alist)
(push '(font . "JetBrainsMono NF-14") default-frame-alist)

;; Don't resize the frame to fit default settings; avoids extra layout work.
(setq frame-inhibit-implied-resize t)

;;; early-init.el ends here
