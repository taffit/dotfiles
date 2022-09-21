;; Initialization for dired-x which includes the dired-jump
;; The following should open a folder in the same buffer
(put 'dired-find-alternate-file 'disabled nil)

(add-hook 'dired-load-hook
  (function (lambda () (load "dired-x"))))
(autoload 'dired-jump "dired-x"
  "Jump to dired buffer corresponding to current buffer."
  'interactive)

(after 'evil
    ;; Not opening an additional buffer in dired
    (evil-define-key 'normal dired-mode-map "h" 'dired-up-directory)
    (evil-define-key 'normal dired-mode-map "l" 'dired-find-alternate-file)
    (evil-define-key 'normal dired-mode-map "o" 'dired-sort-toggle-or-edit)
    (evil-define-key 'normal dired-mode-map "v" 'dired-toggle-marks)
    (evil-define-key 'normal dired-mode-map "m" 'dired-mark)
    (evil-define-key 'normal dired-mode-map "u" 'dired-unmark)
    (evil-define-key 'normal dired-mode-map "U" 'dired-unmark-all-marks)
    (evil-define-key 'normal dired-mode-map "c" 'dired-create-directory)
    (evil-define-key 'normal dired-mode-map "f" 'find-file)
    (evil-define-key 'normal dired-mode-map "n" 'evil-search-next)
    (evil-define-key 'normal dired-mode-map "N" 'evil-search-previous)
    (evil-define-key 'normal dired-mode-map "q" 'kill-this-buffer)
)

(provide 'init-dired)

