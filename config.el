;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; TODO polish & submit adaptive-wrap feature
;;  - new modules/editor/adaptive-wrap
;;  - hook to existing indent detection
;;  - customize indent multiplier per mode

;; TODO sp: insert semicolon after enum/class/struct
;; TODO sp: insert namespace close comment
;; TODO sp: multiline comment expansion (used to work?)
;; TODO sp: smarter arglist-close

;; TODO cc: fix inclass -> template-args-cont
;; TODO cc: fix company firing on c-electric-slash
;; TODO cc: fix c-electric-brace reformatting namespace close
;; TODO cc: fix duplicate close-angle-brace on #include complete
;; TODO cc: expand-region support for template arguments

;; TODO flycheck: limit size of posframe for giant errors

;; TODO ccls: look for */compile_commands.json
;; - set compilationDatabaseDirectory in ccls-initialization-options
;; - needs to be a per-project setting...

;; TODO pkgbuild-mode: customize faces

;; TODO perl: configure cperl-mode for doom

;; TODO support naming buffers relative to project
;; TODO forward/backward-word whitespace handling
;; TODO save-place support for pdf-view-mode

;; TODO improve projectile-find-other-file ordering (closest)
;; TODO improve counsel-recentf ordering (recent first)
;; TODO improve switch-workspace-buffer ordering (virtuals last)
;; TODO stabilise +ivy/project-search order after ivy-resume
;; TODO profile & improve lsp-mode performance while typing
;; TODO investigate smooth scrolling options

(setq-default
 doom-theme    'doom-tomorrow-night
 doom-font     (font-spec :family "Hack" :size 12) ;(+hidpi-font-size 12))
 doom-big-font (font-spec :family "Hack" :size 18) ;(+hidpi-font-size 18))

 mouse-yank-at-point t
 set-mark-command-repeat-pop t
 split-height-threshold nil
 split-width-threshold nil
 x-stretch-cursor t

 indent-tabs-mode nil
 tab-width 2

 +ivy-buffer-icons t
 +ivy-buffer-preview t
 +workspaces-on-switch-project-behavior nil

 ;; NOTE last resort for debug messages from ccls
 ;;ccls-args '("-v=2" "-log-file=/tmp/ccls.log")
 ccls-initialization-options '(:index (:threads 2)))

(save-place-mode +1)
(global-subword-mode +1)

(set-popup-rule! "^\\*Customize" :ignore t)

(after! ivy
  (setq ivy-magic-tilde nil
        ivy-extra-directories nil
        ivy-use-virtual-buffers t
        ivy-virtual-abbreviate 'abbreviate))

(after! swiper
  (setq swiper-goto-start-of-match t))

(after! company
  (setq company-minimum-prefix-length 2))

(after! expand-region
  (setq expand-region-subword-enabled t))

(after! flycheck
  (setq flycheck-display-errors-delay 0.1))

(after! lsp-ui
  (setq lsp-enable-indentation nil
        lsp-ui-sideline-enable nil))

(after! projectile
  (setq projectile-indexing-method 'hybrid))

(after! ace-window
  (setq aw-swap-invert t))

(after! hl-todo
  (add-to-list 'hl-todo-keyword-faces `("HACK" . ,(face-foreground 'warning))))

(after! nav-flash
  (add-hook! 'doom-enter-buffer-hook
    (+nav-flash|delayed-blink-cursor)))

(after! org
  (add-hook! :append 'org-mode-hook
    (org-bullets-mode -1)))

(after! python
  (setq python-indent-offset 2))

(after! text-mode
  (add-to-list 'auto-mode-alist '("\\.log\\'" . text-mode))

  (add-hook! 'text-mode-hook
    (visual-line-mode +1)

    ;; display ansi color codes
    ;; FIXME do this without modifying buffer
    (let ((inhibit-read-only t))
      (ansi-color-apply-on-region (point-min) (point-max)))

    ;; hide dos eol markers
    (setq buffer-display-table (make-display-table))
    (aset buffer-display-table ?\^M [])))

(after! cc-mode
  (add-to-list 'auto-mode-alist '("\\.ipp\\'" . c++-mode))

  (font-lock-add-keywords
   'c++-mode '(("\\<\\(\\w+::\\)" . font-lock-constant-face)))

  (after! smartparens
    (sp-local-pair 'c++-mode "(" nil :post-handlers '(:rem ("||\n[i]" "RET")))
    (sp-local-pair 'c++-mode "{" nil :post-handlers '(:rem ("| "      "SPC")))
    (sp-local-pair 'c++-mode "<" nil :actions nil))

  ;; HACK install bindings late as possible
  (add-transient-hook! 'c-mode-common-hook
    (map! :map c-mode-base-map
        ":" #'+cc-better-electric-colon))

  (c-add-style
   "flat" '("Google"
            (tab-width      . 2)
            (c-basic-offset . 2)
            (c-offsets-alist
             (inlambda              . 0)
             (inexpr-statement      +cc-collapse-brace-list +)
             (arglist-intro         +cc-collapse-brace-list google-c-lineup-expression-plus-4)
             (arglist-cont          +cc-collapse-brace-list 0)
             (arglist-cont-nonempty +cc-collapse-brace-list ++)
             (arglist-close         +cc-better-arglist-close 0)
             (statement-cont        . ++)
             (template-args-cont    . ++))))

  (setq-default
   c-default-style "flat"
   c-basic-offset tab-width
   +cc-default-header-file-mode 'c++-mode))

(def-package! adaptive-wrap
  :hook (c-mode-common . +adaptive-wrap|init-cc-mode)
  :config
  (defun +adaptive-wrap|init-cc-mode ()
    (setq adaptive-wrap-extra-indent (* c-basic-offset 2))
    (adaptive-wrap-prefix-mode +1)
    (visual-line-mode +1)))

(def-package! flycheck-package
  :after flycheck
  :config
  (flycheck-package-setup))

(def-package! google-c-style
  :after cc-mode
  :config
  (c-add-style "Google" google-c-style))

(def-package! goto-line-preview
  :defer t
  :init
  (global-set-key [remap goto-line] #'goto-line-preview))

(def-package! pkgbuild-mode
  :defer t
  :config
  (add-hook! 'pkgbuild-mode-hook
    (setq mode-name "PKGBUILD"
          mode-line-process nil)))

(load! "+bindings")
(load! "+faces")
