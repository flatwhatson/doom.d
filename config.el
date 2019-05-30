;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; TODO polish & submit adaptive-wrap feature
;;  - new modules/editor/adaptive-wrap
;;  - hook to existing indent detection
;;  - customize indent multiplier per mode

;; TODO cc+sp: insert semicolon after enum/class/struct
;; TODO cc+sp: fix extra " or > on include completion

;; TODO flycheck: limit size of posframe for giant errors

;; TODO ccls: look for */compile_commands.json
;;  - set compilationDatabaseDirectory in ccls-initialization-options
;;  - needs to be a per-project setting...

;; TODO pkgbuild-mode: customize faces

;; TODO perl: configure cperl-mode for doom

;; TODO save-place support for pdf-view-mode
;;  - org-pdfview can bookmark into PDFs, maybe relevant

;; TODO profile & improve lsp+cc performance
;; https://github.com/amosbird/serverconfig/blob/6e5723225bff9a9512c1c0e3ca4ae87f99f81b5d/.config/doom/modules/private/amos-cc/config.el#L285


(setq-default
 doom-theme    'doom-tomorrow-night
 doom-font     (font-spec :family "Hack" :size (+hidpi-font-size 12))
 doom-big-font (font-spec :family "Hack" :size (+hidpi-font-size 18))

 org-directory "~/Dropbox/org/"

 mouse-yank-at-point t
 set-mark-command-repeat-pop t
 x-stretch-cursor t

 indent-tabs-mode nil
 tab-width 2

 +ivy-buffer-preview t
 +workspaces-on-switch-project-behavior nil
 uniquify-buffer-name-style 'forward

 ;; NOTE last resort for debug messages from ccls
 ;;ccls-args '("-v=2" "-log-file=/tmp/ccls.log")
 ccls-initialization-options '(:index (:threads 2)))

(save-place-mode +1)
(global-subword-mode +1)


(after! ace-window
  (setq aw-swap-invert t))

(after! company
  (setq company-minimum-prefix-length 2))

(after! evil
  (setq evil-want-fine-undo t))

(after! evil-snipe
  (setq evil-snipe-spillover-scope 'visible))

(after! expand-region
  (setq expand-region-subword-enabled t))

(after! flycheck
  (setq flycheck-display-errors-delay 0.1))

(after! hl-todo
  (add-to-list 'hl-todo-keyword-faces `("HACK" . ,(face-foreground 'warning))))

(after! ivy
  (setq ivy-extra-directories nil
        ivy-magic-tilde nil))

(after! lsp-ui
  (setq lsp-enable-indentation nil
        lsp-enable-on-type-formatting nil
        lsp-enable-symbol-highlighting nil
        lsp-ui-sideline-enable nil))

(after! projectile
  (setq projectile-indexing-method 'hybrid))

(after! swiper
  (setq swiper-goto-start-of-match t))

(after! vc
  (setq vc-suppress-confirm t))

(after! which-key
  (setq which-key-idle-delay 0.5))


(after! org
  (add-hook 'org-mode-hook #'turn-off-smartparens-mode)
  (remove-hook 'org-mode-hook #'org-bullets-mode)
  (remove-hook 'org-tab-first-hook #'+org|cycle-only-current-subtree))

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
    (sp-local-pair 'c++-mode "{" nil :post-handlers '(:rem ("| "      "SPC"))))

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

(def-package! org-pomodoro
  :defer t)

(def-package! pkgbuild-mode
  :defer t
  :config
  (add-hook! 'pkgbuild-mode-hook
    (setq mode-name "PKGBUILD"
          mode-line-process nil)))


(load! "+bindings")
(load! "+faces")
