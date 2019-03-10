;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;; HACK counsel fork due to pending bugfix
;; https://github.com/abo-abo/swiper/pull/1959
(package! counsel
  :recipe (:fetcher github :repo "flatwhatson/swiper"))

(package! adaptive-wrap)
(package! google-c-style)
(package! goto-line-preview)
