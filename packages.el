;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

(package! evil-lisp-state)
(package! flycheck-package)
(package! pkgbuild-mode)

;; FIXME straight.el doesn't respect repo's default branch
;; https://github.com/raxod502/straight.el/issues/279
(package! google-c-style
  :recipe (:host github :repo "google/styleguide" :branch "gh-pages"))

;; HACK use clangd instead of ccls
(package! ccls :disable t)

;; HACK https://github.com/politza/pdf-tools/pull/588
(package! pdf-tools
  :recipe (:host github :repo "flatwhatson/pdf-tools" :branch "fix-macros")
  :pin "4a10c35e626ab6d7970dfd7335f4f883b1b879ef")
