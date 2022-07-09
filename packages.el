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
  :pin "518aeed7e806c9bf19d389bbfc15b9af17bc0d62")
