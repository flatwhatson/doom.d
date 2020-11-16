;;; ~/.doom.d/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +flat/cc-collapse-brace-list (langelem)
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
(defun +flat/cc-better-arglist-close (langelem)
  "Indent arglist-close as though the closing paren was not present."
  ;; TODO indent unless followed by ; or {
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
(defun +flat/cc-better-electric-colon-a (arg)
  "Only auto-complete after TWO colons."
  (when (and company-mode
             (eq major-mode 'c++-mode)
             (eq (char-before (point)) ?:)
             (not (eq (char-before (1- (point))) ?:)))
    (company-cancel)))

;;;###autoload
(defun +flat/ivy-partial-or-complete ()
  "Complete the minibuffer text as much as possible.
If the text hasn't changed as a result, complete the minibuffer text with the
currently selected candidate."
  ;; FIXME restore candidate after ivy-partial
  (interactive)
  (cond ((ivy-partial))
        ((or (eq this-command last-command)
             (eq ivy--length 1))
         (ivy-insert-current))))

;;;###autoload
(defun +flat/ivy-project-search-emacsd (&optional arg initial-query)
  "Perform a project search in `doom-emacs-dir'."
  (interactive "P")
  (+ivy/project-search arg initial-query doom-emacs-dir))

;;;###autoload
(defun +flat/ivy-other-project-search (&optional arg initial-query)
  "Prompt for a project, then search from the project root."
  (interactive "P")
  (+ivy/project-search arg initial-query
                       (if-let (projects (projectile-relevant-known-projects))
                           (completing-read "Search project: " projects
                                            nil t nil nil (doom-project-root))
                         (user-error "There are no known projects"))))

;;;###autoload
(defun +flat/insert-uuid ()
  "Insert a randomly generated UUID."
  (interactive)
  (insert
   (string-trim-right (shell-command-to-string "uuidgen"))))
