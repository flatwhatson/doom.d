;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

(package! adaptive-wrap)
(package! google-c-style)
(package! goto-line-preview)
(package! org-pomodoro)
(package! pkgbuild-mode)

(package! flycheck-package)
(package! gif-screencast)

;; TODO keycast doom compatibility
(package! keycast)

;; HACK pending PR for non-greedy globbing
(package! prescient
  :recipe (:fetcher github :repo "flatwhatson/prescient.el"))
