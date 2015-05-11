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
;;(load-theme 'wombat t)
;;(load-theme 'misterioso)
(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
(load-theme 'solarized t)
(add-hook 'after-make-frame-functions
          (lambda (frame)
            (let ((mode (if (display-graphic-p frame) 'light 'dark)))
              (set-frame-parameter frame 'background-mode mode)
              (set-terminal-parameter frame 'background-mode mode))
            (enable-theme 'solarized)))

;;; package manager
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			   ("marlalade" . "http://marmalade-repo.org/packages/")

			   ("melpa" . "http://melpa.milkbox.net/packages/")))
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (add-hook 'after-init-hook 'global-company-mode)

  (browse-kill-ring-default-keybindings)
  )

;;; magit
(setq magit-auto-revert-mode nil)

;;; flycheck-mode
(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)

;;; ido
;;(ido-mode t)

;;; helm-mode
(require 'helm-config)
(helm-mode t)
(require 'helm-descbinds)
(eval-after-load 'flycheck
  '(define-key flycheck-mode-map (kbd "C-c ! h") 'helm-flycheck))
;; (define-key flyspell-mode-map (kbd "C-;") 'helm-flyspell-correct)


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

;;; LaTeX/AucTeX
(setq reftex-plug-into-AUCTeX t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

;(setq reftex-plug-into-AUCTeX nil)
(add-hook 'LaTeX-mode-hook (lambda()
			     (set-fill-column 120)
			     (reftex-mode t)
			     (flyspell-mode t)
			     ))
;(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;;(add-hook 'latex-mode-hook 'turn-on-reftex)


;;; autopair
;;(require autopair)

;; yiasnipet
;(require 'yiasnipet)
(yas-global-mode 1)

;;; python
(add-hook 'python-mode-hook (lambda()
			      (show-paren-mode t)
			      (anaconda-mode 1)
			      (eldoc-mode 1)
			      ))

;;; ORG-mode
(require 'ox-beamer) ;; for exporting to beamer
(add-hook 'org-mode-hook (lambda ()
			   (flyspell-mode 1)
			   (setq org-log-done t)
			   ;;;(org-babel-do-load-languages 'org-babel-load-languages '((elasticsearch . t) (python . t) (sparql . t))))
			   (org-babel-do-load-languages 'org-babel-load-languages '((python . t) (sparql . t))))
	  )


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

;;; ssh copnfig
(autoload 'ssh-config-mode "ssh-config-mode" t)
(add-to-list 'auto-mode-alist '(".ssh/config\\'"  . ssh-config-mode))
(add-to-list 'auto-mode-alist '("sshd?_config\\'" . ssh-config-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (js2-refactor yaml-mode vi-tilde-fringe ssh-config-mode sparql-mode org markdown-mode magit karma json-mode js2-mode irony-eldoc helm-google helm-git helm-flyspell helm-flycheck helm-descbinds helm-company helm-bibtex grunt gnuplot gitignore-mode github-theme flycheck-pos-tip flycheck-irony flycheck-color-mode-line company-math company-irony company-c-headers company-auctex company-anaconda color-theme browse-kill-ring autopair))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(set-face-attribute 'default nil :height 100)

(provide '.emacs)
;;; .emacs ends here
