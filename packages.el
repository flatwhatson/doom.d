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

;; HACK ivy-rich from github, pending issue
;; https://github.com/melpa/melpa/issues/6069
(package! ivy-rich
  :recipe (:fetcher github :repo "Yevgnen/ivy-rich"))

(package! adaptive-wrap)
(package! google-c-style)
(package! goto-line-preview)
