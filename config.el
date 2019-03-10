;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; TODO polish & submit adaptive-wrap feature
;;  - new modules/editor/adaptive-wrap
;;  - hook to existing indent detection
;;  - customize indent multiplier per mode

;; TODO fix one-star lineup in multiline c comments
;; TODO fix two-star expansion in multiline c comments

;; TODO sp: insert semicolon after enum/class/struct
;; TODO sp: insert namespace close comment
;; TODO sp: smarter arglist-close

;; TODO cc: fix inclass -> template-args-cont

;; TODO doom/kill-project-buffers

;; TODO improve projectile-find-other-file ordering
;; TODO support naming buffers relative to project
;; TODO forward/backward-word whitespace handling

(setq-default
 doom-theme 'doom-tomorrow-night
 doom-font (font-spec :family "Hack" :size (+hidpi-font-size 12))
 doom-big-font (font-spec :family "Hack" :size (+hidpi-font-size 18))

 mouse-yank-at-point t
 set-mark-command-repeat-pop t
 split-height-threshold nil
 x-stretch-cursor t
 tab-width 2

 +workspaces-on-switch-project-behavior nil)

(save-place-mode +1)
(global-subword-mode +1)

(set-popup-rule! "^\\*Customize" :ignore t)

;; HACK lsp-eldoc broken due to missing seq functions
;; https://github.com/emacs-lsp/lsp-mode/commit/24d421dc7e0b0e4d96b468e870e8161656a3142e#r32570721
;; https://github.com/emacs-mirror/emacs/blob/master/lisp/emacs-lisp/seq.el
(after! lsp-ui
  (setq lsp-eldoc-enable-signature-help nil))

(after! ivy
  (setq ivy-magic-tilde nil
        ivy-extra-directories nil
        ivy-use-virtual-buffers t
        ivy-virtual-abbreviate 'abbreviate
        +ivy-buffer-preview t))

(after! company
  (setq company-minimum-prefix-length 2))

(after! flycheck
  (setq flycheck-display-errors-delay 0.1))

(after! lsp-ui
  (setq lsp-enable-indentation nil
        lsp-ui-sideline-enable nil))

(after! projectile
  (setq projectile-indexing-method 'hybrid))

(after! hl-todo
  (add-to-list 'hl-todo-keyword-faces `("HACK" . ,(face-foreground 'warning))))

(after! nav-flash
  (add-hook! 'doom-enter-buffer-hook
    (+nav-flash/blink-cursor)))

(after! org
  (add-hook! :append 'org-mode-hook
    (org-bullets-mode -1)))

(after! cc-mode
  (add-to-list 'auto-mode-alist '("\\.ipp\\'" . c++-mode))

  (font-lock-add-keywords
   'c++-mode '(("\\<\\(\\w+::\\)" . font-lock-constant-face)))

  (after! smartparens
    (sp-local-pair 'c++-mode "(" nil :post-handlers '(:rem ("||\n[i]" "RET")))
    (sp-local-pair 'c++-mode "{" nil :post-handlers '(:rem ("| "      "SPC"))))

  (map! :map c++-mode-map
        ":" #'+cc-better-electric-colon)

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

(def-package! google-c-style
  :after cc-mode
  :config
  (c-add-style "Google" google-c-style))

(def-package! goto-line-preview
  :commands goto-line-preview
  :init
  (global-set-key [remap goto-line] 'goto-line-preview))

(load! "+bindings")
