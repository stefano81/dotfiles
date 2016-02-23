;;; package --- Summary
;;; Commentary:
;;; Code:

(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  )

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			   ("marlalade" . "http://marmalade-repo.org/packages/")

			   ("melpa" . "http://melpa.milkbox.net/packages/")))
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (add-hook 'after-init-hook 'global-company-mode)

  (browse-kill-ring-default-keybindings)

  (when (not package-archive-contents)
    (package-refresh-contents))
  )

;;; flyspell
(setq ispell-program-name 'aspell)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default)))
 ;'(flycheck-display-errors-function (function flycheck-pos-tip-error-messages))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (yaml-mode anaconda-mode helm-bind-key java-snippets irony-eldoc csv-mode all yasnippet sparql-mode solarized-theme scala-mode color-theme-solarized sbt-mode json-mode flycheck-tip ssh-config-mode js2-mode markdown-mode flycheck-pos-tip autopair helm-descbinds browse-kill-ring org magit-filenotify helm-flyspell helm-flycheck helm-company helm-bibtex flycheck-irony flycheck-color-mode-line emacs-eclim company-math company-irony company-c-headers company-auctex))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; general
(set-fill-column 120)

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
(require 'helm-bind-key)
(eval-after-load 'flycheck
  '(define-key flycheck-mode-map (kbd "C-c ! h") 'helm-flycheck))
;; (define-key flyspell-mode-map (kbd "C-;") 'helm-flyspell-correct)

;;; flycheck-mode
;; (eval-after-load 'flycheck
;;   '(custom-set-variables
;;     '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))

;;; eclim
(require 'eclim)
(global-eclim-mode)
(require 'eclimd)
(setq eclim-eclipse-dirs '"~/eclipse")
(setq eclim-executable '"~/eclipse/eclim")
(require 'company-emacs-eclim)
(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)

;;; company
(require 'company)
(require 'company-emacs-eclim)
;(company-emacs-eclim-setup)
( eval-after-load 'company (lambda()
 			    (add-to-list 'company-backends 'company-irony)
 			    (add-to-list 'company-backends 'company-anaconda)
			    ;;(add-to-list 'company-backends 'company-eclim)
			    (add-to-list 'company-backends 'company-emacs-eclim)
 			    )
 		 )
(global-company-mode t)

;;; Java
(require 'company-emacs-eclim)
(add-hook 'java-mode-hook (lambda()
 			    (eclim-mode)
 			    ))
;;; irony
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
;;;(add-hook 'irony-mode-hook #'irony-eldoc-mode)

;;; LaTeX/AucTeX
(setq reftex-plug-into-AUCTeX t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(setq reftex-plug-into-AUCTeX nil)
(add-hook 'LaTeX-mode-hook (lambda()
 			     (set-fill-column 120)
 			     (reftex-mode t)
 			     (flyspell-mode t)
 			     ))
;(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;;(add-hook 'latex-mode-hook 'turn-on-reftex)

;;; autopair
(require 'autopair)
(show-paren-mode t)

;; yiasnipet
;(require 'yasnipet)
(yas-global-mode t)

;;; python
(add-hook 'python-mode-hook (lambda()
 			      (show-paren-mode t)
 			      (anaconda-mode 1)
 			      (eldoc-mode 1)
 			      ))

;;; enable encryption
(require 'epa-file)
(epa-file-enable)

;;; ORG-mode
(require 'ox-beamer) ;; for exporting to beamer
(add-hook 'org-mode-hook (lambda ()
 			   (flyspell-mode 1)
			   (set-fill-column 120)
 			   (setq org-log-done t)
 			   ;;;(org-babel-do-load-languages 'org-babel-load-languages '((elasticsearch . t) (python . t) (sparql . t))))
 			   (org-babel-do-load-languages 'org-babel-load-languages '((python . t) (sparql . t))))
 	  )
(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
;; GPG key to use for encryption
;; Either the Key ID or set to nil to use symmetric encryption.
(setq org-crypt-key nil)

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

;; ;;; ssh config
(autoload 'ssh-config-mode "ssh-config-mode" t)
(add-to-list 'auto-mode-alist '(".ssh/config\\'"  . ssh-config-mode))
(add-to-list 'auto-mode-alist '("sshd?_config\\'" . ssh-config-mode))

;; scala
(setq exec-path (append exec-path (list "~/Utilites/scala/bin" )))
(require 'scala-mode2)
(require 'sbt-mode)
;; (require 'ensime)
;; (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
;; (eval-after-load "scala-mode"
;;   '(progn
;;      (define-key scala-mode-map (kbd "<f9>") 'ensime-builder-build)
;;      (define-key scala-mode-map (kbd "<f10>") 'ensime-inf-switch)))


;; theme
;(load-theme 'misterioso)
(load-theme 'solarized-dark 1 nil)

(provide '.emacs)
;;; .emacs ends here
