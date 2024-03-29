;;; ~/.doom.d/+faces.el -*- lexical-binding: t; -*-

(custom-set-faces!
  '((lsp-face-highlight-read
     lsp-face-highlight-write
     lsp-face-highlight-textual)
    :foreground nil :distant-foreground nil :background nil :weight bold :underline nil)
  '(demangled :box nil)
  '(info-menu-star :foreground nil)
  `(link-visited :foreground ,(doom-color 'dark-blue))
  `(whitespace-tab :foreground ,(doom-color 'base0) :background nil)
  '(diff-removed :background nil))
