;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;; HACK expand-region-subword, waiting for MELPA listing
;; https://github.com/melpa/melpa/pull/6087
(package! expand-region-subword
  :recipe (:fetcher github :repo "flatwhatson/expand-region-subword"))

;; HACK keycast fork, WIP doom compatibility
(package! keycast
  :recipe (:fetcher github :repo "flatwhatson/keycast"))

(package! adaptive-wrap)
(package! google-c-style)
(package! goto-line-preview)
(package! pkgbuild-mode)

(package! flycheck-package)
(package! gif-screencast)
