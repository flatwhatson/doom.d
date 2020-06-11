;;; ~/.doom.d/+faces.el -*- lexical-binding: t; -*-

(custom-set-faces!
  '((lsp-face-highlight-read lsp-face-highlight-write lsp-face-highlight-textual)
    :foreground nil :distant-foreground nil :background nil :weight bold :underline nil)
  '(ivy-minibuffer-match-face-2 :background nil)
  '(demangled :box nil)
  '(info-menu-star :foreground nil)
  `(link-visited :foreground ,(doom-color 'dark-blue)))
