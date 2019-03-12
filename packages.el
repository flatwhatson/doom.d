;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;; HACK counsel fork due to pending bugfix
;; https://github.com/abo-abo/swiper/pull/1959
(package! counsel
  :recipe (:fetcher github :repo "flatwhatson/swiper"))

;; HACK ivy-rich from github, waiting for melpa
(package! ivy-rich
  :recipe (:fetcher github :repo "Yevgnen/ivy-rich"))

(package! adaptive-wrap)
(package! google-c-style)
(package! goto-line-preview)
