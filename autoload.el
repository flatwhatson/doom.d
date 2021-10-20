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
(defun +flat/cc-company-double-colon-a (result)
  "Detect a single colon at point as in `public:'."
  (and result
       (not (and (eq major-mode 'c++-mode)
                 (eq (char-before (point)) ?:)
                 (not (eq (char-before (1- (point))) ?:))))))

;;;###autoload
(defun +flat/insert-uuid ()
  "Insert a randomly generated UUID."
  (interactive)
  (insert
   (string-trim-right (shell-command-to-string "uuidgen"))))
