;;; ~/.doom.d/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +hidpi-font-size (size)
  "Auto-scale the font size based on DPI.

On standard 24\" 1080p display: 12 -> 12
On high DPI 14\" 1440p display: 12 -> 18"

  ;; NOTE values from `display-pixel-height' and `display-mm-height'
  ;; 24 inch 1920x1080 primary:   pixel-height 1080 mm-height 292
  ;; 14 inch 2560x1440 primary:   pixel-height 1440 mm-height 254
  ;; 29 inch 2560x1080 secondary: pixel-height 1080 mm-height 254 (from primary)

  ;; NOTE dual-monitor `display-monitor-attributes-list'
  ;; (((name . "eDP1")
  ;;   (geometry 0 0 1920 1080)
  ;;   (mm-size 310 170)
  ;;   (frames))
  ;;  ((name . "HDMI1")
  ;;   (geometry 1920 0 2560 1080)
  ;;   (mm-size 670 280)
  ;;   (frames #<frame *ielm* – Doom Emacs 0x1221c30> #<frame  0x74f2450>)))

  ;; TODO find monitor for current frame, use that geometry/mm-size for calcs
  ;; TODO make scaling factor configurable and more intuitive

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
(defun +cc-better-electric-colon-a (arg)
  "Only auto-complete after TWO colons."
  (when (and company-mode
             (eq major-mode 'c++-mode)
             (eq (char-before (point)) ?:)
             (not (eq (char-before (1- (point))) ?:)))
    (company-cancel)))

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
currently selected candidate."
  ;; FIXME restore candidate after ivy-partial
  (interactive)
  (cond ((ivy-partial))
        ((or (eq this-command last-command)
             (eq ivy--length 1))
         (ivy-insert-current))))

;;;###autoload
(defun +ivy/other-project-search (&optional arg initial-query directory)
  "Performs a project search from the project root.

Uses the first available search backend from `+ivy-project-search-engines'. If
ARG (universal argument), include all files, even hidden or compressed ones, in
the search."
  (interactive "P")
  (let ((directory (or directory
                       (if-let (projects (projectile-relevant-known-projects))
                           (completing-read "Search project: " projects
                                            nil t nil nil (doom-project-root))
                         (user-error "There are no known projects")))))
    (+ivy/project-search arg initial-query directory)))
