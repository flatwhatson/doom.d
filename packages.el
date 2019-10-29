;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

(package! flycheck-package)
(package! page-break-lines)
(package! pkgbuild-mode)

;; FIXME straight.el doesn't respect repo's default branch
;; https://github.com/raxod502/straight.el/issues/279
(package! google-c-style
  :recipe (:host github :repo "google/styleguide" :branch "gh-pages"))
