;;; ~/.doom.d/+init.el -*- lexical-binding: t; -*-

;; HACK prevent undo-tree error during debug-init
(after! undo-tree (setq-default buffer-undo-tree (make-undo-tree)))
