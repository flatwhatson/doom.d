;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;; HACK counsel fork, pending PR
;; https://github.com/abo-abo/swiper/pull/1959
(package! counsel
  :recipe (:fetcher github :repo "flatwhatson/swiper"))

;; HACK expand-region fork, upstream closed for PRs
(package! expand-region
  :recipe (:fetcher github :repo "flatwhatson/expand-region.el"))
(package! expand-region-subword
  :recipe (:fetcher github :repo "flatwhatson/expand-region-subword"))

;; HACK multiple-cursors fork, upstream closed for PRs
(package! multiple-cursors
  :recipe (:fetcher github :repo "flatwhatson/multiple-cursors.el"))

(package! adaptive-wrap)
(package! flycheck-package)
(package! google-c-style)
(package! goto-line-preview)
(package! pkgbuild-mode)
