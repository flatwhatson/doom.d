;;; ~/.doom.d/+init.el -*- lexical-binding: t; -*-

;; It is pitch black. You are likely to be eaten by a grue.

(setq comp-async-jobs-number (string-to-number
                              (shell-command-to-string "nproc")))
