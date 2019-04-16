;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

(package! adaptive-wrap)
(package! google-c-style)
(package! goto-line-preview)
(package! pkgbuild-mode)

(package! flycheck-package)
(package! gif-screencast)

;; TODO objed doom compatibility
(package! objed)

;; TODO keycast doom compatibility
(package! keycast)

;; HACK WIP swiper-isearch improvements
(package! swiper
  :recipe (:fetcher github :repo "flatwhatson/swiper"))
