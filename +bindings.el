;;; ~/.doom.d/+bindings.el -*- lexical-binding: t; -*-

(map!

 "C-'"          #'imenu

 (:leader
   :desc "Switch to previous buffer" "SPC" #'evil-switch-to-windows-last-buffer
   :desc "M-x"                       ";"   #'execute-extended-command
   :desc "Eval expression"           ":"   #'eval-expression

   (:prefix "b"
    :desc "Switch to scratch buffer" "x"   #'doom/switch-to-scratch-buffer
    :desc "Pop up scratch buffer"    "X"   #'doom/open-scratch-buffer)

   (:prefix "f"
    :desc "Find file from here"      "f"   #'+default/find-file-under-here
    :desc "Find file"                "F"   #'find-file)

   (:prefix "i"
    :desc "UUID"                     "U"   #'+flat/insert-uuid)

   (:prefix ("k" . "kill")
     :desc "Kill 'em all!"                "A" #'doom/kill-all-buffers
     :desc "Kill this buffer"             "b" #'doom/kill-this-buffer-in-all-windows
     :desc "Kill other buffers"           "o" #'doom/kill-buried-buffers
     :desc "Kill other buffers & windows" "O" #'doom/kill-other-buffers
     :desc "Kill project buffers"         "p" #'doom/kill-project-buffers)

   (:prefix "o"
    :desc "Ielm"                          "i" #'ielm
    :desc "Compilation"                   "c" (λ! (pop-to-buffer compilation-last-buffer))
    :desc "Messages"                      "m" (λ! (pop-to-buffer "*Messages*")))

   (:prefix "q"
     :desc "Restart Emacs"                "r" #'doom/restart
     :desc "Restart & restore Emacs"      "R" #'doom/restart-and-restore))

 (:after evil
  (:map evil-window-map
   "f" #'doom/window-maximize-buffer
   "e" #'balance-windows))

 (:after vertico
  (:map vertico-map
   "RET"   #'vertico-directory-enter
   "DEL"   #'vertico-directory-delete-char
   "M-DEL" #'vertico-directory-delete-word))

 (:after woman
  (:map woman-mode-map
   :n "o"  #'link-hint-open-link))

 (:after ccls
  (:map (c-mode-map c++-mode-map)
   :n "C-h" nil
   :n "C-j" nil
   :n "C-k" nil
   :n "C-l" nil))

 (:after compile
  (:map (compilation-mode-map compilation-minor-mode-map)
   "h" nil))

 (:after pdf-view
   (:map pdf-view-mode-map
     "q"   nil
     "Q"   nil
     "o"   #'pdf-links-action-perform
     "C-i" #'pdf-history-forward
     "C-o" #'pdf-history-backward)))
