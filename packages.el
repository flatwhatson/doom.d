;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;; HACK expand-region fork, fix org-mode unfolding
;; https://github.com/flatwhatson/expand-region.el/commit/a667a126dccdb60a7d00555f05dff11395279ac2
;; https://github.com/magnars/expand-region.el/commit/1f153a89a188013ac64586988b46418a5485b541#comments
(package! expand-region
  :recipe (:fetcher github :repo "flatwhatson/expand-region.el"))

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
