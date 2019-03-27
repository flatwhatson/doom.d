;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;; HACK expand-region fork, waiting for MELPA update
(package! expand-region
  :recipe (:fetcher github :repo "magnars/expand-region.el"))

;; HACK keycast fork, WIP doom compatibility
(package! keycast
  :recipe (:fetcher github :repo "flatwhatson/keycast"))

(package! adaptive-wrap)
(package! google-c-style)
(package! goto-line-preview)
(package! pkgbuild-mode)

(package! flycheck-package)
(package! gif-screencast)
