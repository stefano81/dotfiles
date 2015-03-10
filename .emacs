;;; package -- Summary

;;; Commentary:

;;; to avoid issues under OS X
;;; Code:
(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  )

;;; package manager
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			   ("marlalade" . "http://marmalade-repo.org/packages/")

			   ("melpa" . "http://melpa.milkbox.net/packages/")))
  (add-hook 'after-init-hook #'global-flycheck-mode)
  )

;;; flycheck-mode
(eval-after-load 'flycheck
  '(custom-set-variables
   '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))


;;; color themes
;(load-theme 'wombat)
(load-theme 'misterioso)


;;; general
(global-linum-mode 1)
(define-key global-map (kbd "C-c ;") 'iedit-mode)

;;; ORG-mode
(add-hook 'org-mode-hook (lambda ()
			   (flyspell-mode 1)

;; 			   (org-capture-templates (quote (("t" "Todo" entry (file+headline "~/Documents/Dropbox/MobileOrg/newgtd.org" "Tasks") "* TODO %^{Brief Description} %^g%?
;;   Added: %U") ("m" "Meeting" entry (file+datetree "~/Documents/Dropbox/MobileOrg/meetings.org") "* [%^{with}] %^{description} %? :MEETING:" :clock-in t :clock-resume t) ("p" "Presentation" entry (file+datetree "~/Documents/Dropbox/MobileOrg/presentations.org") "* %^{description} %? :TALK:" :clock-in t :clock-resume t) ("n" "Note" entry (file+headline "~/Documents/Dropbox/MobileOrg/notes.org" "") "
;; * %^{topic} %T 
;; %i%?
;; "))))
			   ))

;;; CEDET
;(require 'cedet)
;(semantic-mode 1)
;(global-ede-mode 1)
;(global-semantic-idle-scheduler-mode 1) ; to allow the reparsing of the files
;(global-semantic-idle-completions-mode t)
;(global-semantic-decoration-mode nil)
;(semantic-load-enable-minimum-features)
;(semantic-load-enable-code-helpers)


;;; autopair
(require 'autopair)
(autopair-global-mode) ;; to enable in all buffers
(setq autopair-autowrap t)

;;; yasnippet
;;; should be loaded before auto complete so that they can work together
(require 'yasnippet)
(yas-global-mode 1)

;;; autocomplete
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict/")
;; (setq ac-sources '(ac-source-filename
;; 		   ac-source-functions
;; 		   ac-source-yasnippet
;; 		   ac-source-symbols
;; 		   ac-source-words-in-same-mode-buffers
;; 		   ac-source-dictionary
;; 		   ac-source-c-headers))
;;(add-to-list 'ac-sources 'ac-source-c-headers)

(setq ac-use-fuzzy t)
(setq ac-auto-start 3)
(setq ac-auto-show-menu 3)

;;; javascript
(require 'js2-mode)
(require 'js2-refactor)

(add-hook 'js2-mode-hook (lambda()
			   (ac-js2-mode)
 			   (show-paren-mode t)
 			   (auto-complete-mode t)
			   (js2-auto-indent-p t)
			   (js2-enter-indents-newline t)
 			   (js2-indent-on-enter-key t)
 			   (setq js2-basic-offset 4)
;			   (flycheck-mode)
 ;			   (flymake-jshint-load)
 			   ))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

;;; JSON
;(require 'flymake-json)
;(add-hook 'json-mode (lambda()
;		       (flymake-json-load)
;		       ))

;;; force c++-mode
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; ;;; Clang-format
(load "/usr/share/emacs/site-lisp/clang-format-3.7/clang-format.el")
(global-set-key [C-tab] 'clang-format-buffer)

;; (add-hook 'c++-mode-hook 'irony-mode)
;; (add-hook 'c-mode-hook 'irony-mode)
;; ;;(add-hook 'objc-mode-hook 'irony-mode) ;; not using Objective-C.. for now

;; ;; replace the `completion-at-point' and `complete-symbol' bindings in
;; ;; irony-mode's buffers by irony-mode's function
;; (defun my-irony-mode-hook ()
;;   (define-key irony-mode-map [remap completion-at-point]
;;     'irony-completion-at-point-async)
;;   (define-key irony-mode-map [remap complete-symbol]
;;     'irony-completion-at-point-async))
;; (add-hook 'irony-mode-hook 'my-irony-mode-hook)

(require 'auto-complete-c-headers)
(require 'auto-complete-clang-async)
;;; c++11 mode
(defun my-c++-mode-hook()
  ;;(c-set-style "my-style")
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'ac-sources 'ac-source-semantic)
  (add-to-list 'ac-sources '(ac-source-clang-async))
  (add-to-list 'achead:include-directories '".")

  (setq flycheck-clang-language-standard "c++11")

  (setq c-tab-always-indent nil) ;; in C tab insert tab not always

  (show-paren-mode 1)

  (setq c-basic-offset 4)
  (setq indent-tabs-mode nil)
  (auto-fill-mode)
  (c-toggle-auto-hungry-state 1)

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

;;; Python
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)


;;; AUCTeX
;(require 'auctex)
(add-hook 'LaTeX-mode-hook (lambda()(visual-line-mode)
(flyspell-mode)
(LaTeX-math-mode)
(turn-on-reftex)))
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)
(require 'auto-complete-auctex)

;;; ssh config
(autoload 'ssh-config-mode "ssh-config-mode" t)
(add-to-list 'auto-mode-alist '(".ssh/config\\'"  . ssh-config-mode))
(add-to-list 'auto-mode-alist '("sshd?_config\\'" . ssh-config-mode))

;;; gdb-mode
(setq gdb-many-windows t)

;;; gnuplot-mode
(eval-after-load 'gnuplot-mode
  '(add-hook 'gnuplot-mode-hook
	     (lambda()
	       (flyspell-prog-mode)
	       (add-hook 'before-save-hook
			 'whitespace-cleanup nill t))))

;(setq width (max width (+ (length str) 1)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
