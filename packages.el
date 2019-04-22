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

;; HACK PR for objed support
;; https://github.com/hlissner/emacs-doom-themes/pull/275
(package! doom-themes
  :recipe (:fetcher github :repo "flatwhatson/emacs-doom-themes" :files ("*.el" "themes/*.el")))

;; HACK PR for objed support
;; https://github.com/seagle0128/doom-modeline/pull/159
(package! doom-modeline
  :recipe (:fetcher github :repo "flatwhatson/doom-modeline"))
