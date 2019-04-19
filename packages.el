;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

(package! adaptive-wrap)
(package! google-c-style)
(package! goto-line-preview)
(package! pkgbuild-mode)

(package! flycheck-package)
(package! gif-screencast)

;; TODO keycast doom compatibility
(package! keycast)

;; HACK PR for swiper-isearch improvements
;; https://github.com/abo-abo/swiper/pull/2029
(package! swiper
  :recipe (:fetcher github :repo "flatwhatson/swiper"))
