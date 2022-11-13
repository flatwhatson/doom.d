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
  :pin "0ffe3572f5c90fd383a36c1bdf30f1c964a668da")
