;;; ~/.doom.d/+init.el -*- lexical-binding: t; -*-

;; HACK ensure emacs gets focus (eg. after restart)
(select-frame-set-input-focus (selected-frame))

;; HACK prevent undo-tree error during debug-init
(after! undo-tree (setq-default buffer-undo-tree (make-undo-tree)))
