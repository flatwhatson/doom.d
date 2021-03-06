;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; HACK ensure emacs gets focus (eg. after restart)
(add-hook! 'window-setup-hook
  (select-frame-set-input-focus (selected-frame)))

(setq-default
 doom-theme    'doom-tomorrow-night
 doom-font     (font-spec :family "Hack" :size 12)
 doom-big-font (font-spec :family "Hack" :size 18)

 +doom-dashboard-banner-dir (expand-file-name "banners/" doom-private-dir)
 +doom-dashboard-banner-file "stallman-splash.png"
 +doom-dashboard-banner-padding '( 2 . 1 )

 org-directory "~/Dropbox/org/"

 mouse-yank-at-point t
 set-mark-command-repeat-pop t
 split-height-threshold nil
 split-width-threshold nil
 x-stretch-cursor t
 shr-use-fonts nil

 indent-tabs-mode nil
 tab-width 8

 +workspaces-on-switch-project-behavior nil
 uniquify-buffer-name-style 'forward
 sentence-end-double-space t

 which-key-idle-delay 0.5)

(dolist (path '("^/usr/local/"
                "/\\.emacs\\.d/core"
                "/\\.emacs\\.d/modules"
                "/\\.emacs\\.d/\\.local/straight/repos"))
  (add-to-list 'auto-minor-mode-alist (cons path 'read-only-mode)))

(defun +projectile-ignore-project-p (project-root)
  (string-match-p "/\\.emacs\\.d/\\.local/straight/repos" project-root))

(add-hook! 'doom-init-ui-hook
  (global-subword-mode +1)
  (+global-word-wrap-mode +1))


(after! ace-window
  (setq aw-swap-invert t))

(after! autorevert
  (setq auto-revert-verbose nil))

(after! company
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 2))

(after! counsel
  (setq counsel-compile-build-directories nil))

(after! evil-org
  (remove-hook 'org-tab-first-hook #'+org-cycle-only-current-subtree-h))

(after! evil-snipe
  (setq evil-snipe-repeat-keys t
        evil-snipe-scope 'whole-visible
        evil-snipe-repeat-scope 'whole-visible
        evil-snipe-spillover-scope 'whole-buffer))

(after! expand-region
  (setq expand-region-subword-enabled t))

(after! flycheck
  (setq flycheck-display-errors-delay 0.1))

(after! info
  (advice-add #'Info-up :after #'doom-recenter-a))

(after! ivy
  (setq ivy-extra-directories nil
        ivy-magic-tilde nil))

(after! (ivy projectile)
  ;; HACK more actions for `projectile-find-other-file'
  (require 'counsel-projectile)
  (ivy-add-actions
   'projectile-completing-read
   (cdr counsel-projectile-find-file-action)))

(after! lsp-mode
  (setq lsp-auto-guess-root t
        lsp-enable-indentation nil
        lsp-enable-on-type-formatting nil
        lsp-enable-semantic-highlighting nil
        lsp-file-watch-threshold nil
        lsp-progress-via-spinner nil
        lsp-ui-doc-enable nil
        lsp-ui-peek-enable nil
        lsp-ui-sideline-enable nil)
  (set-lookup-handlers! 'lsp-ui-mode nil))

(after! org
  (add-hook 'org-mode-hook #'turn-off-smartparens-mode))

(after! projectile
  (setq projectile-indexing-method 'hybrid
        projectile-ignored-project-function #'+projectile-ignore-project-p))

(after! swiper
  (setq swiper-goto-start-of-match t))

(after! vc
  (setq vc-suppress-confirm t))

(after! js2-mode
  (setq js2-basic-offset 2))

(after! python
  (setq python-indent-guess-indent-offset nil
        python-indent-offset 2))

(after! scheme
  (put 'test-group 'scheme-indent-function 1)
  (setq geiser-mode-start-repl-p t))

(after! text-mode
  (add-hook! 'text-mode-hook
    ;; Apply ANSI color codes
    (with-silent-modifications
      (ansi-color-apply-on-region (point-min) (point-max)))
    ;; Hide DOS EOL markers
    (setq buffer-display-table (make-display-table))
    (aset buffer-display-table ?\^M [])))

(after! cmake-mode
  (after! smartparens
    (sp-local-pair 'cmake-mode "(" nil :post-handlers '(:rem ("||\n[i]" "RET")))))

(after! cc-mode
  (add-to-list 'auto-mode-alist '("\\.ipp\\'" . c++-mode))

  (font-lock-add-keywords
   'c++-mode '(("\\<\\(\\w+::\\)" . font-lock-constant-face)))

  (after! smartparens
    (sp-local-pair 'c++-mode "(" nil :post-handlers '(:rem ("||\n[i]" "RET")))
    (sp-local-pair 'c++-mode "{" nil :post-handlers '(:rem ("| "      "SPC"))))

  (advice-add 'c-electric-colon :after #'+flat/cc-better-electric-colon-a)

  (c-add-style
   "flat" '("Google"
            (tab-width      . 2)
            (c-basic-offset . 2)
            (c-offsets-alist
             (inlambda              . 0)
             (inexpr-statement      +flat/cc-collapse-brace-list +)
             (arglist-intro         +flat/cc-collapse-brace-list google-c-lineup-expression-plus-4)
             (arglist-cont          +flat/cc-collapse-brace-list 0)
             (arglist-cont-nonempty +flat/cc-collapse-brace-list ++)
             (arglist-close         +flat/cc-better-arglist-close 0)
             (statement-cont        . ++)
             (template-args-cont    . ++))))

  (setf (alist-get 'c++-mode c-default-style) "flat")

  (setq +cc-default-header-file-mode 'c++-mode))


(use-package! evil-lisp-state
  :init
  (setq evil-lisp-state-global t)
  :config
  (map! :leader "l" evil-lisp-state-map))

(use-package! flycheck-package
  :after flycheck
  :config
  (flycheck-package-setup))

(use-package! google-c-style
  :after cc-mode
  :config
  (c-add-style "Google" google-c-style))

(use-package! pkgbuild-mode
  :defer t
  :init
  (setq pkgbuild-update-sums-on-save nil)
  :config
  (add-hook! 'pkgbuild-mode-hook
    (setq mode-name "PKGBUILD"
          mode-line-process nil)))


(load! "+bindings")
(load! "+faces")
(load! "+popups")
(load! "+secret" nil t)
