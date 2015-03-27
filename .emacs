;;; package -- Summary

;;; Commentary:

;;; Code:

;;; to avoid issues under OS X
(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  )

;;; color themes
(load-theme 'wombat)
;;(load-theme 'misterioso)

;;; package manager
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			   ("marlalade" . "http://marmalade-repo.org/packages/")

			   ("melpa" . "http://melpa.milkbox.net/packages/")))
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (add-hook 'after-init-hook 'global-company-mode)
  )

;;; ido
(ido-mode t)

;;; prelude
;; (require 'prelude-c)
;; ;; (require 'prelude-clojure)
;; ;; (require 'prelude-coffee)
;; ;; (require 'prelude-common-lisp)
;; ;; (require 'prelude-css)
;; (require 'prelude-emacs-lisp)
;; (require 'prelude-erc)
;; ;; (require 'prelude-erlang)
;; ;; (require 'prelude-elixir)
;; ;; (require 'prelude-haskell)
;; (require 'prelude-js)
;; ;; (require 'prelude-latex)
;; (require 'prelude-lisp)
;; ;; (require 'prelude-mediawiki)
;; (require 'prelude-org)
;; (require 'prelude-perl)
;; ;; (require 'prelude-python)
;; ;; (require 'prelude-ruby)
;; ;; (require 'prelude-scala)
;; (require 'prelude-scheme)
;; ;; (require 'prelude-scss)
;; ;; (require 'prelude-web)
;; (require 'prelude-xml)

;;; flycheck-mode
(eval-after-load 'flycheck
  '(custom-set-variables
   '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))

;;; company
(eval-after-load 'company (lambda()
			    (add-to-list 'company-backends 'company-irony)
			    (add-to-list 'company-backends 'company-anaconda)
			    )
)

;;; autopair
;;(require autopair)

;; yiasnipet
;(require 'yiasnipet)
(yas-global-mode 1)

;;; python
(add-hook 'python-mode-hook (lambda()
			      (anaconda-mode 1)
			      (eldoc-mode 1)
			      ))

;;; ORG-mode
(add-hook 'org-mode-hook (lambda ()
			   (flyspell-mode 1)
			   (setq org-log-done t)))


;;; irony
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
;;(add-hook 'irony-mode-hook #'irony-eldoc-mode)


;;; C/C++
(defun my-c++-mode-hook()
  (setq c-tab-always-indent nil) ;; in C tab insert tab not always
  (setq c-basic-offset 4)
  (setq indent-tabs-mode nil)
  (setq flycheck-clang-language-standard "c++11")

  (irony-mode)
  (show-paren-mode t)
  (eldoc-mode)
  (irony-eldoc)

  (font-lock-add-keywords
   nil '(;; complete some fundamental keywords
 	 ("\\<\\(void\\|unsigned\\|signed\\|char\\|short\\|bool\\|int\\|long\\|float\\|double\\)\\>" . font-lock-keyword-face)
 	 ;; add the new C++11 keywords
 	 ("\\<\\(alignof\\|alignas\\|constexpr\\|decltype\\|noexcept\\|nullptr\\|static_assert\\|thread_local\\|override\\|final\\)\\>" . font-lock-keyword-face)
 	 ("\\<\\(char[0-9]+_t\\)\\>" . font-lock-keyword-face)
 	 ;; PREPROCESSOR_CONSTANT
	 ("\\<[A-Z]+[A-Z_]+\\>" . font-lock-constant-face)
	 ;; hexadecimal numbers
 	 ("\\<0[xX][0-9A-Fa-f]+\\>" . font-lock-constant-face)
 	 ;; integer/float/scientific numbers
 	 ("\\<[\\-+]*[0-9]*\\.?[0-9]+\\([ulUL]+\\|[eE][\\-+]?[0-9]+\\)?\\>" . font-lock-constant-face)
 	 ;; user-types (customize!)
 	 ("\\<[A-Za-z_]+[A-Za-z_0-9]*_\\(t\\|type\\|ptr\\)\\>" . font-lock-type-face)
 	 ("\\<\\(xstring\\|xchar\\)\\>" . font-lock-type-face)
 	 )
   )
  )

(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(add-hook 'c-mode-hook 'my-c++-mode-hook)

;;; javascript
(require 'js2-mode)
(require 'js2-refactor)
(add-hook 'js2-mode-hook (lambda()
			   (ac-js2-mode)
 			   (show-paren-mode t)
			   (js2-auto-indent-p t)
			   (js2-enter-indents-newline t)
 			   (js2-indent-on-enter-key t)
 			   (setq js2-basic-offset 4)
			   (flycheck-mode)
 			   ))

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

;;; ssh config
(autoload 'ssh-config-mode "ssh-config-mode" t)
(add-to-list 'auto-mode-alist '(".ssh/config\\'"  . ssh-config-mode))
(add-to-list 'auto-mode-alist '("sshd?_config\\'" . ssh-config-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-display-errors-function (function flycheck-pos-tip-error-messages))
 '(package-selected-packages
   (quote
    (karma grunt company auctex vi-tilde-fringe ssh-config-mode js2-refactor irony-eldoc gitignore-mode github-theme git-commit-mode flycheck-pos-tip flycheck-irony company-math company-irony company-c-headers company-anaconda color-theme autopair))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(set-face-attribute 'default nil :height 100)

(provide '.emacs)
;;; .emacs ends here
