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
     :desc "Ielm"                         "i" #'ielm)

   (:prefix "q"
     :desc "Restart Emacs"                "r" #'doom/restart
     :desc "Restart & restore Emacs"      "R" #'doom/restart-and-restore)

   (:prefix "s"
     :desc "Search directory"                 "d" #'+ivy/project-search-from-cwd
     :desc "Search directory (all files)"     "D" (λ!! #'+ivy/project-search-from-cwd t)
     :desc "Search emacs.d"                   "e" #'+flat/ivy-project-search-emacsd
     :desc "Search emacs.d (all files)"       "E" (λ!! #'+flat/ivy-project-search-emacsd t)
     :desc "Search project"                   "p" #'+ivy/project-search
     :desc "Search project (all files)"       "P" (λ!! #'+ivy/project-search t)
     :desc "Search other project"             "o" #'+flat/ivy-other-project-search
     :desc "Search other project (all files)" "O" (λ!! #'+flat/ivy-other-project-search t)))

 (:after evil
  (:map evil-window-map
   "f" #'doom/window-maximize-buffer
   "e" #'balance-windows))

 (:after ivy
   (:map ivy-minibuffer-map
     [return] #'ivy-alt-done
     "RET"    #'ivy-alt-done
     [tab]    #'+flat/ivy-partial-or-complete
     "TAB"    #'+flat/ivy-partial-or-complete))

 (:after pdf-view
   (:map pdf-view-mode-map
     "q" nil
     "Q" nil)))
