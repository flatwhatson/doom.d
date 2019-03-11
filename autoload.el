;;; ~/.doom.d/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +hidpi-font-size (size)
  (if (or (not (display-pixel-height))
          (not (display-mm-height)))
      size
    (round (/ (* size 0.27
                 (display-pixel-height))
              (display-mm-height)))))

;;;###autoload
(defun +cc-collapse-brace-list (langelem)
  "Collapse extra indentation inside a brace-list."
  (when (or (save-excursion
              (save-match-data
                (beginning-of-line)
                (skip-chars-backward " \t\n" (c-langelem-pos langelem))
                (eq (char-before) ?\{)))
            (save-excursion
              (save-match-data
                (beginning-of-line)
                (skip-chars-forward " \t\n")
                (eq (char-after) ?\}))))
    0))

;;;###autoload
(defun +cc-better-arglist-close (langelem)
  "Indent arglist-close as though the closing paren was not present."
  (let ((symbol
         (save-excursion
           (save-match-data
             (beginning-of-line)
             (skip-chars-backward " \t\n" (c-langelem-pos langelem))
             (cond ((eq (char-before) ?\() 'arglist-intro)
                   ((eq (char-before) ?\,) 'arglist-cont-nonempty)
                   ((eq (char-before) ?\;) 'statement)
                   (t                      'arglist-cont))))))
    (when symbol
      (c-calc-offset (cons symbol (cdr langelem))))))

;;;###autoload
(defun +cc-better-electric-colon (arg)
  "Insert a colon, maybe re-indent, then maybe complete."
  (interactive "*P")
  (c-electric-colon arg)
  (when (and company-mode
             (eq major-mode 'c++-mode)
             (eq (char-before (point)) ?:))
    (company-cancel)
    (when (eq (char-before (1- (point))) ?:)
      (company-auto-begin))))

;;;###autoload
(defun +isearch-exit-start-of-match ()
  "Exit isearch at the beginning of the match."
  (interactive)
  (isearch-exit)
  (when (< isearch-other-end (point))
    (goto-char isearch-other-end)))

;;;###autoload
(defun +ivy-partial-or-complete ()
  "Complete the minibuffer text as much as possible.
If the text hasn't changed as a result, complete the minibuffer text with the
current selection."
  (interactive)
  (cond ((ivy-partial))
        ((or (eq this-command last-command)
             (eq ivy--length 1))
         (let ((selection
                (string-remove-suffix
                 "/" (ivy-state-current ivy-last))))
           (delete-region (minibuffer-prompt-end) (point-max))
           (insert (setq ivy-text selection))))))

;;;###autoload
(defun +projectile-find-file-in-known-projects-other-window ()
  "Jump to a file in any of the known projects."
  (interactive)
  (find-file-other-window
   (projectile-completing-read
    "Find file in projects: "
    (projectile-all-project-files))))

;;;###autoload
(defun +insert-file-name-base ()
  "Insert the base name of the file visited by the current buffer."
  (interactive)
  (insert (file-name-base)))
