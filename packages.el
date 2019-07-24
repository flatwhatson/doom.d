;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

(package! adaptive-wrap)
(package! flycheck-package)
(package! lsp-python-ms)
(package! org-pomodoro)
(package! pkgbuild-mode)

;; HACK doom-community-themes waiting on MELPA
;; https://github.com/melpa/melpa/pull/6324
(package! doom-community-themes
  :recipe (:host github :repo "Emiller88/emacs-doom-community-themes"))

;; FIXME straight.el doesn't respect repo's default branch
;; https://github.com/raxod502/straight.el/issues/279
(package! google-c-style
  :recipe (:host github :repo "google/styleguide" :branch "gh-pages"))
