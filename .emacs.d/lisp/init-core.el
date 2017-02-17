;; My core customizations
;; Don't show those horrible buttons
(tool-bar-mode -1)

;; break long lines at word boundaries
(visual-line-mode 1)

;; lockfiles are evil.
(setq create-lockfiles nil)

;; Non-working auto-save is evil, too.
(setq auto-save-default nil)

;; also tabs are evil
(setq-default indent-tabs-mode nil)
;; Indent by 4 spaces
(setq-default tab-width 4)

;; number columns in the status bar
(column-number-mode)

;; require a trailing newline
(setq require-final-newline t)

;; don't put intitial text in scratch buffer
(setq initial-scratch-message nil)

;; Disable toolbars and splash screens.
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))

;; from <https://github.com/bling/dotemacs/>
(defmacro after (feature &rest body)
  "After FEATURE is loaded, evaluate BODY."
  (declare (indent defun))
  `(eval-after-load ,feature
     '(progn ,@body)))

;; make sure $PATH is set correctly
;;(use-package exec-path-from-shell
  ;;:ensure exec-path-from-shell
  ;;:config
  ;;(progn
    ;;(exec-path-from-shell-copy-env "PATH")
    ;;(exec-path-from-shell-copy-env "PYTHONPATH")
;;))

(ignore-errors ;; windows
  (exec-path-from-shell-initialize))

;; Hide startup messages
(setq inhibit-splash-screen t
      inhibit-startup-echo-area-message t
      inhibit-startup-message t)

;; Line numbers
(global-linum-mode 1)
(add-hook 'find-file-hook (lambda () (linum-mode 1)))
(setq linum-format "%4d\u2502")

;; Disable vertical scrollbars in all frames.
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Disable menu bar for all (trying this out)
(menu-bar-mode -1)

;; Disable the menu bar in console emacs.
(unless (display-graphic-p) (menu-bar-mode -1))

(show-paren-mode 1)
(setq large-file-warning-threshold nil)
(setq custom-safe-themes t)

;;(use-package material-theme
  ;;:ensure t)

;;(use-package solarized-theme
  ;;:ensure t)

(use-package base16-theme
  :ensure t)

;; Auto-indent on return
(define-key global-map (kbd "RET") 'newline-and-indent)
;;(load-theme 'misterioso t)
;;(load-theme 'material t)
;;(load-theme 'base16-oceanicnext t)
;;(load-theme 'base16-ocean t)
;;(load-theme 'base16-solarized-dark t)
;;(load-theme 'base16-tomorrow-night t)
;;(load-theme 'base16-twilight t)
;;(load-theme 'base16-unikitty-dark t)
;;(load-theme 'base16-spacemacs t)
;;(load-theme 'base16-pico t)
;;(load-theme 'base16-pop t)
;;(load-theme 'base16-phd t)
;;(load-theme 'base16-paraiso t)
;;(load-theme 'base16-monokai t)
;;(load-theme 'base16-onedark t)
;;(load-theme 'base16-materia t)
(load-theme 'base16-isotope t)
;;(load-theme 'solarized-dark t)
;;(set-terminal-parameter nil 'background-mode 'dark)
;; Loading up the package for getting approximate colors in the terminal
;;
(use-package color-theme-approximate
  :ensure t
  :init
    (color-theme-approximate-on))

;;(defvar backup-dir "~/.emacs.d/.saves/")
;;(setq backup-directory-alist (list (cons "." backup-dir)))
(setq backup-directory-alist `(("." . "~/.emacs.d/.saves")))
(setq make-backup-files nil)
(defvar my-auto-save-folder "~/.emacs.d/.saves/"
  "Directory used for Emacs backups.")

(setq auto-save-file-name-transforms
      `((".*" , my-auto-save-folder t)))

;; Only scroll one line when near the bottom of the screen, instead
;; of jumping the screen around.
(setq scroll-conservatively 9999
      scroll-preserve-screen-position t)

;; Let me write `y` or `n` even for important stuff that would normally require
;; me to fully type `yes` or `no`.
(defalias 'yes-or-no-p 'y-or-n-p)

;; Enable the mouse in terminal mode.
(xterm-mouse-mode 1)

;; UTF-8 everything!
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Flash the frame to represent a bell.
(setq visible-bell t)
;; nevermind that's annoying
;;(setq ring-bell-function 'ignore)

;; The default of 16 is too low. Give me a 64-object mark ring.
;; Across all files, make it 128.
(setq mark-ring-max 64)
(setq global-mark-ring-max 128)

;; Display the current function name in the modeline.
(which-function-mode 0)

;; Show me the new saved file if the contents change on disk when editing.
(global-auto-revert-mode 1)

;; Repurposed from
;; <https://github.com/bling/dotemacs/blob/master/config/init-core.el>
(defun my-find-file-check-large-file ()
  "Check the size of files when loading, and don't let me break them."
  (when (> (buffer-size) (* 1024 1024 1024))
    (setq buffer-read-only t)
    (buffer-disable-undo)
    (fundamental-mode)))

(defun my-setup-file-defaults ()
  "Set the defaults for a new file opening."
  (my-find-file-check-large-file)
  (setq show-trailing-whitespace t)
  (electric-indent-mode 1))

;; Adapted from
;; <https://github.com/bling/dotemacs/blob/master/config/init-core.el>
(defun my-do-not-kill-scratch-buffer ()
  "Don't let the scratch buffer die."
  (if (member (buffer-name (current-buffer)) '("*scratch*" "*Messages*"))
      (progn
        (bury-buffer)
        nil)
    t))

(add-hook 'kill-buffer-query-functions 'my-do-not-kill-scratch-buffer)

(add-hook 'find-file-hook 'my-setup-file-defaults)

(random t) ;; seed

(plist-put minibuffer-prompt-properties
           'point-entered 'minibuffer-avoid-prompt)

;; Thanks
;; http://www.jesshamrick.com/2013/03/31/macs-and-emacs/
;; for the my-system-is-x functions below.
(defun my-system-is-mac ()
  (interactive)
  (string-equal system-type "darwin"))

(defun my-system-is-linux ()
  (interactive)
  (string-equal system-type "gnu/linux"))

(defun my-system-is-windows ()
  (interactive)
  (string-equal system-type "windows-nt"))

(defun my-system-is-freebsd ()
  (interactive)
  (string-equal system-type "gnu/kfreebsd"))

(defun my-system-is-cygwin ()
  (interactive)
  (string-equal system-type "cygwin"))


;; I never look at right-side fringes. Do you?
;; Seems to create problems in cygwin, trying with a function
(if (not (my-system-is-cygwin))
    (set-fringe-style '(8 . 0)))


(provide 'init-core)

