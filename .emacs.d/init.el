;-*-Emacs-Lisp-*-

;;; Commentary:
;;
;; I have nothing substantial to say here.
;;
;;; Code:
;; Don't litter my init file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

;; Start maximized
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized))))) ;; start maximized


(require 'package)
;; Leave this here, or package.el will just add it again.
(package-initialize)
(setq package-enable-at-startup nil)

;;(require 'package)
;;(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
;;(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
;;(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(setq package-archives '(("melpa" . "http://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(eval-when-compile
  (require 'use-package))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'custom-theme-load-path (expand-file-name "themes" user-emacs-directory))

;;; Larger package-specific configurations.
(require 'init-core)
(require 'init-powerline)
(require 'init-evil)
(require 'init-dired)
(require 'init-autocomplete)
(require 'init-flycheck)
;;(require 'init-functions)

;; Packages
(use-package magit
  :defer t)

(use-package helm
  :defer t)

(use-package elisp-slime-nav
  :ensure t
  :init
  (progn
    (defun my-lisp-hook ()
        (elisp-slime-nav-mode)
        (turn-on-eldoc-mode))
    (add-hook 'emacs-lisp-mode-hook 'my-lisp-hook)
    )
  :config
  (progn
    (evil-mode 1)
    (evil-define-key 'normal emacs-lisp-mode-map (kbd "K")
      'elisp-slime-nav-describe-elisp-thing-at-point)
  )
)

;; For autohotkey-scripts I'm using this one: https://github.com/ralesi/ahk-mode
(use-package ahk-mode
  :defer t)

;; Enabling markdown / github-flavoured markdown
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.mkd\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; Enabling reStructuredText on certain file-types automatically
(setq auto-mode-alist
      (append '(("\\.txt\\'" . rst-mode)
                ("\\.rst\\'" . rst-mode)
                ("\\.rest\\'" . rst-mode)) auto-mode-alist))

;;  From: https://www.reddit.com/r/emacs/comments/1s9tfk/emacs_server_mode_on_windows/
;;
;;  This makes Emacs ignore the "-e (make-frame-visible)" 
;;  that it gets passed when started by emacsclientw.
;;
;;(add-to-list 'command-switch-alist '("(make-frame-visible)" .
                 ;;(lambda (s))))
;;  This starts the Emacs server when .emacs gets loaded
;;
(require 'server)
(if (not (server-running-p)) (server-start))
;;
;;  This changes C-x C-c to just hide Emacs until the next
;;  time you use it.  We rebind C-M-c to be the command to
;;  really kill Emacs.
;;
(defun my-done ()
  ;;"Exit server buffers and hide the main Emacs window"
  (interactive)
  (server-edit)
  (make-frame-invisible nil t))

(global-set-key (kbd "C-x C-c") 'my-done)
(global-set-key (kbd "C-M-c") 'save-buffers-kill-emacs)

(provide 'init)
;;; init.el ends here
