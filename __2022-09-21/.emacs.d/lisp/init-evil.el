;; ustom settings for evil-mode.
;; Gets its own file as it will be the most used / configured module
;;
(use-package evil-leader
  :commands (evil-leader-mode global-evil-leader-mode)
  :ensure evil-leader
  :demand evil-leader
  :config
  (progn
    (evil-leader/set-leader "<SPC>")
    (evil-leader/set-key
      "b" 'ibuffer
      "w" 'save-buffer
      "d" 'dired-jump
      "x" 'helm-M-x
      "q" 'kill-buffer-and-window
      "n" 'next-buffer
      "p" 'previous-buffer
      "c" 'kill-buffer
      "e" 'evil-ace-jump-word-mode
      "l" 'evil-ace-jump-line-mode
    )
    (setq evil-leader/in-all-states 1)
    (global-evil-leader-mode t)
  )
)

(use-package ace-jump-mode
  :ensure ace-jump-mode)

(use-package evil
  :ensure evil
  :config
  (progn
    (evil-mode 1)
    (setq evil-normal-state-modes
      (append evil-emacs-state-modes
        evil-insert-state-modes
        evil-normal-state-modes
        evil-motion-state-modes))
    ;; See http://emacs.stackexchange.com/a/15054
    (fset 'evil-visual-update-x-selection 'ignore)
    ;;; esc quits
    (define-key evil-normal-state-map [escape] 'keyboard-quit)
    (define-key evil-visual-state-map [escape] 'keyboard-quit)
    (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
    (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
    (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
    (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
    (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
    ;; As found here: https://juanjoalvarez.net/es/detail/2014/sep/19/vim-emacsevil-chaotic-migration-guide/
    (setq evil-emacs-state-cursor '("red" box))
    (setq evil-normal-state-cursor '("green" box))
    (setq evil-visual-state-cursor '("orange" box))
    (setq evil-insert-state-cursor '("red" bar))
    (setq evil-replace-state-cursor '("red" hollow))
    (setq evil-operator-state-cursor '("yellow" hollow))

    ;; Navigate to visible lines
    (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
    (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
    ;; For not losing C-h in emacs I just use rotate with C-j / C-k
    ;;(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
    ;;(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
    ;;(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
    ;;(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
    (define-key evil-normal-state-map (kbd "C-j") 'evil-window-next)
    (define-key evil-normal-state-map (kbd "C-k") 'evil-window-prev)

    ;; As found on http://bling.github.io/blog/2013/10/27/emacs-as-my-leader-vim-survival-guide/
    (defadvice evil-ex-search-next (after advice-for-evil-ex-search-next activate)
      (evil-scroll-line-to-center (line-number-at-pos)))

    ;; Defining the word boundaries like in vim
    ;; Found here: http://emacs.stackexchange.com/a/20717/14494
    (with-eval-after-load 'evil
	(defalias #'forward-evil-word #'forward-evil-symbol))
  )
)

(provide 'init-evil)
;;; init-evil.el ends here
