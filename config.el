;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(setq-default
 doom-theme    'doom-tomorrow-night
 doom-font     (font-spec :family "Hack" :size 14)
 doom-big-font (font-spec :family "Hack" :size 18)

 +doom-dashboard-banner-dir (expand-file-name "banners/" doom-private-dir)
 +doom-dashboard-banner-file "stallman-splash.png"
 +doom-dashboard-banner-padding '( 2 . 1 )

 +vc-gutter-in-remote-files t

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
 enable-local-variables t

 which-key-idle-delay 0.5)

(dolist (path '("^/usr/local/"
                "/\\.emacs\\.d/core"
                "/\\.emacs\\.d/modules"
                "/\\.emacs\\.d/\\.local/straight/repos"))
  (add-to-list 'auto-minor-mode-alist (cons path 'read-only-mode)))

(defun +projectile-ignore-project-p (project-root)
  (string-match-p "/\\.emacs\\.d/\\.local/straight/repos" project-root))

(add-hook! 'doom-init-ui-hook
  (global-subword-mode +1))

(after! ace-window
  (setq aw-swap-invert t))

(after! autorevert
  (setq auto-revert-verbose nil))

(after! browse-url
  (setq browse-url-browser-function 'browse-url-firefox))

(after! company
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 2))

(after! company-yasnippet
  (defadvice! +flat/company-yasnippet-candidates-a (orig-fn &rest args)
    :override #'company-yasnippet--candidates
    nil))

(after! compile
  ;; TODO get xterm-color working for compile
  (setq compilation-environment '("TERM=xterm-256color")
        compilation-scroll-output 'first-error
        compilation-skip-threshold 2)
  (defadvice! +flat/compilation-filter-a (orig-fn proc string)
    :around #'compilation-filter
    (funcall orig-fn proc (xterm-color-filter string))))

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

(after! lsp-mode
  (setq lsp-auto-guess-root t
        lsp-enable-file-watchers nil
        lsp-enable-indentation nil
        lsp-enable-on-type-formatting nil
        lsp-file-watch-threshold nil
        lsp-headerline-breadcrumb-enable nil
        lsp-lens-enable nil
        lsp-progress-via-spinner nil
        lsp-semantic-tokens-enable nil
        lsp-ui-doc-enable nil
        lsp-ui-peek-enable nil
        lsp-ui-sideline-enable nil)
  (set-lookup-handlers! 'lsp-ui-mode nil))

(after! org
  (add-hook 'org-mode-hook #'turn-off-smartparens-mode))

(after! projectile
  (setq projectile-ignored-project-function #'+projectile-ignore-project-p))

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
  (defun ansify-buffer ()
    (with-silent-modifications
      (ansi-color-apply-on-region (point-min) (point-max)))
    ;; Hide DOS EOL markers
    (setq buffer-display-table (make-display-table))
    (aset buffer-display-table ?\^M [])
    (make-local-variable 'after-revert-hook)
    (add-hook! 'after-revert-hook :local #'ansify-buffer))
  (add-hook! 'text-mode-hook #'ansify-buffer))

(after! ccls
  (plist-put! ccls-initialization-options
              :index '(:threads 2 :trackDependency 1)
              :cache `(:directory ,(expand-file-name "~/.ccls-cache")))

  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-tramp-connection (lambda () (cons ccls-executable ccls-args)))
    :major-modes '(c-mode c++-mode cuda-mode objc-mode)
    :remote? t
    :server-id 'ccls-remote
    :multi-root nil
    :notification-handlers
    (lsp-ht ("$ccls/publishSkippedRanges" #'ccls--publish-skipped-ranges)
            ("$ccls/publishSemanticHighlight" #'ccls--publish-semantic-highlight))
    :initialization-options (lambda () ccls-initialization-options)
    :library-folders-fn ccls-library-folders-fn)))

(after! (lsp-javascript tramp)
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-tramp-connection (lambda ()
                                            (cons lsp-clients-typescript-tls-path
                                                  lsp-clients-typescript-server-args)))
    :activation-fn 'lsp-typescript-javascript-tsx-jsx-activate-p
    :completion-in-comments? t
    :initialization-options (lambda ()
                              (list :disableAutomaticTypingAcquisition lsp-clients-typescript-disable-automatic-typing-acquisition
                                    :logVerbosity lsp-clients-typescript-log-verbosity
                                    :maxTsServerMemory lsp-clients-typescript-max-ts-server-memory
                                    :npmLocation lsp-clients-typescript-npm-location
                                    :plugins lsp-clients-typescript-plugins
                                    :preferences lsp-clients-typescript-preferences))
    :initialized-fn (lambda (workspace)
                      (with-lsp-workspace workspace
                        (lsp--set-configuration
                         (ht-merge (lsp-configuration-section "javascript")
                                   (lsp-configuration-section "typescript")))))
    :ignore-messages '("readFile .*? requested by TypeScript but content not available")
    :server-id 'ts-ls-remote
    :remote? t
    :request-handlers (ht ("_typescript.rename" #'lsp-javascript--rename)))))

(after! (lsp-pyright tramp)
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-tramp-connection (lambda ()
                                            (cons "pyright-langserver"
                                                  lsp-pyright-langserver-command-args)))
    :major-modes '(python-mode)
    :server-id 'pyright-remote
    :remote? t
    :multi-root lsp-pyright-multi-root
    :initialized-fn (lambda (workspace)
                      (with-lsp-workspace workspace
                        (lsp--set-configuration
                         (make-hash-table :test 'equal))))
    :notification-handlers (lsp-ht ("pyright/beginProgress" 'lsp-pyright--begin-progress-callback)
                                   ("pyright/reportProgress" 'lsp-pyright--report-progress-callback)
                                   ("pyright/endProgress" 'lsp-pyright--end-progress-callback)))))

(after! (lsp-rust tramp)
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-tramp-connection (lambda ()
                                            lsp-rust-analyzer-server-command))
    :major-modes '(rust-mode rustic-mode)
    :priority (if (eq lsp-rust-server 'rust-analyzer) 1 -1)
    :initialization-options 'lsp-rust-analyzer--make-init-options
    :notification-handlers (ht<-alist lsp-rust-notification-handlers)
    :action-handlers (ht ("rust-analyzer.runSingle" #'lsp-rust--analyzer-run-single)
                         ("rust-analyzer.debugSingle" #'lsp-rust--analyzer-debug-lens)
                         ("rust-analyzer.showReferences" #'lsp-rust--analyzer-show-references))
    :library-folders-fn (lambda (_workspace) lsp-rust-library-directories)
    :after-open-fn (lambda ()
                     (when lsp-rust-analyzer-server-display-inlay-hints
                       (lsp-rust-analyzer-inlay-hints-mode)))
    :ignore-messages nil
    :server-id 'rust-analyzer-remote
    :remote? t
    :custom-capabilities `((experimental . ((snippetTextEdit . ,(and lsp-enable-snippet (featurep 'yasnippet)))))))))

(after! (lsp-cmake tramp)
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-tramp-connection "cmake-language-server")
    :major-modes '(cmake-mode)
    :server-id 'cmakels-remote
    :remote? t)))

(after! tramp
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path))

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

  (advice-add #'company--should-begin    :filter-return #'+flat/cc-company-double-colon-a)
  (advice-add #'company--should-continue :filter-return #'+flat/cc-company-double-colon-a)

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

  (setf (alist-get 'other c-default-style) "flat")

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
