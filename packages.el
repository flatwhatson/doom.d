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
  :pin "c69e53599bc38af404a820ff8de510f4951da782")
