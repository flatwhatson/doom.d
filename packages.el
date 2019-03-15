;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;; HACK counsel fork, pending PR
;; https://github.com/abo-abo/swiper/pull/1959
(package! counsel
  :recipe (:fetcher github :repo "flatwhatson/swiper"))

;; HACK multiple-cursors fork, pending PR
;; https://github.com/magnars/multiple-cursors.el/pull/355
(package! multiple-cursors
  :recipe (:fetcher github :repo "flatwhatson/multiple-cursors.el"))

(package! adaptive-wrap)
(package! google-c-style)
(package! goto-line-preview)
