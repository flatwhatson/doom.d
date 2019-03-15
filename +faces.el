;;; ~/.doom.d/+faces.el -*- lexical-binding: t; -*-

(add-hook! 'doom-load-theme-hook
  (after! lsp
    (dolist (face '(lsp-face-highlight-read
                    lsp-face-highlight-write
                    lsp-face-highlight-textual))
      (set-face-attribute
       face nil
       :foreground nil :distant-foreground nil :background nil
       :weight 'bold :underline t))
    ))
