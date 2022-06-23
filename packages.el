;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

(unpin! doom-themes)
(package! evil-lisp-state)
(package! flycheck-package)
(package! google-c-style)
(package! guix)
(package! meson-mode)
(package! pkgbuild-mode)
(package! xterm-color)

(package! lsp-mode
  :recipe (:host github :repo "flatwhatson/lsp-mode" :branch "tramp-fix")
  :pin "9c96a471dfd27cebde48bb2d5f375614a9c41ec0")
