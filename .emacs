(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (misterioso)))
 '(desktop-save-mode t)
 '(doc-view-continuous t)
 '(doc-view-resolution 200)
 '(global-visual-line-mode t)
 '(inhibit-startup-screen t)
 '(next-screen-context-lines 4)
 '(save-place t nil (saveplace)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-string-face ((t (:foreground "dark orange")))))
(require 'org);;Config para org mode
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(package-initialize)

(setq org-agenda-files (list "~/org/uni.org"))
;; a ver si condigo darle definición a los pdfs

(require 'doc-view)
(setq doc-view-resolution 144)



(setq package-archives
'(("gnu" . "http://elpa.gnu.org/packages/")
("melpa" . "http://melpa.milkbox.net/packages/")))

(pdf-tools-install)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(ido-mode 1)
(setq ido-enable-flex-matching t)

;;Ponemos los mensajes que salen en otro búfer en el mismo
(tooltip-mode -1)
(setq tooltip-use-echo-area t)


;;Configuración para acceder fácil a archivos recientes con recentf

(require 'recentf)

;; get rid of `find-file-read-only' and replace it with something
;; more useful.
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)

;; enable recent files mode.
(recentf-mode t)

; 50 files ought to be enough.
(setq recentf-max-saved-items 50)

(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

;;Ponemos M-o para cambiar de búfer cuando hay varios abiertos

(global-set-key (kbd "M-ñ") 'other-window)
(global-set-key (kbd"M-o") 'mode-line-other-buffer)

(setq confirm-kill-emacs 'y-or-n-p) ;; Pedir confirmación para salir de emacs

(setq desktop-save-mode t) ;; guardar la sessión al cerrar emacs y restaurarla

(desktop-save-mode 1) ;; guardar sesión emacs

;;Diccionario
(autoload 'ispell-get-word "ispell")
(defun lookup-word (word)
  (interactive (list (save-excursion (car (ispell-get-word nil)))))
  (browse-url (format "http://en.wiktionary.org/wiki/%s" word)))

(global-set-key (kbd "M-+") 'lookup-word)

;;Diccionario güeno de verdá



;;Probamos EXWM
;;(require 'exwm)
;;(require 'exwm-config)
;;(exwm-config-default)

;;Ponemos emacs en pantalla completa
;;(set-frame-parameter nil 'fullscreen 'fullboth)

;; Tell emacs where is your personal elisp lib dir
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; cargamos el diccionario con sus atajos de teclado
(load "define-word")

(global-set-key (kbd "C-c D") 'define-word-at-point)
(global-set-key (kbd "C-c d") 'define-word)


;;Mostramos el número de fila para programar mejor

(add-hook 'prog-mode-hook 'linum-mode)

;;Matar buffer con C-x-K
(defun other-window-kill-buffer ()
  "Kill the buffer in the other window"
  (interactive)
  ;; Window selection is used because point goes to a different window
  ;; if more than 2 windows are present
  (let ((win-curr (selected-window))
        (win-other (next-window)))
    (select-window win-other)
    (kill-this-buffer)
    (select-window win-curr)))

(global-set-key (kbd "C-x K") 'other-window-kill-buffer)

;;Prueba de smooth scrolling
;;(setq scroll-conservatively 10000)
(setq redisplay-dont-pause t
  scroll-margin 1
  scroll-step 1
  scroll-conservatively 10000
  scroll-preserve-screen-position 1)
