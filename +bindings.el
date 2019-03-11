;;; ~/.doom.d/+bindings.el -*- lexical-binding: t; -*-

(map!

 "C-x f" nil
 "C-x l" #'ace-link
 "C-x o" #'ace-window
 "C-x O" #'ace-swap-window

 "C-h ." #'+lookup/documentation
 "M-."   #'+lookup/definition
 "M-?"   #'+lookup/references

 (:leader
   (:prefix "q"
     :desc "Restart Emacs"           "r" #'doom/restart
     :desc "Restart & restore Emacs" "R" #'doom/restart-and-restore))

 (:after isearch
   (:map isearch-mode-map
     [return] #'+isearch-exit-start-of-match
     "RET"    #'+isearch-exit-start-of-match
     "C-RET"  #'isearch-exit))

 (:after ivy
   (:map ivy-minibuffer-map
     [return] #'ivy-alt-done
     "RET"    #'ivy-alt-done
     [tab]    #'+ivy-partial-or-complete
     "TAB"    #'+ivy-partial-or-complete))

 (:after flycheck
   (:map flycheck-mode-map
     "M-n" #'flycheck-next-error
     "M-p" #'flycheck-previous-error))

 (:after projectile
   (:map projectile-command-map
     "f"   #'projectile-find-file
     "4 f" #'projectile-find-file-other-window
     "F"   #'projectile-find-file-in-known-projects
     "4 F" #'+projectile-find-file-in-known-projects-other-window
     "s"   #'+ivy/project-search
     "S"   #'+ivy/project-search-from-cwd)))
