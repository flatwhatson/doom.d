;;; ~/.doom.d/+bindings.el -*- lexical-binding: t; -*-

(map!

 "C-x f" #'counsel-find-file
 "C-x o" #'ace-window
 "C-x O" #'ace-swap-window

 "C-S-s" #'swiper-isearch
 "C-'"   #'imenu

 "C-h ." #'+lookup/documentation
 "M-."   #'+lookup/definition
 "M-?"   #'+lookup/references

 "M-]"   #'forward-paragraph
 "M-["   #'backward-paragraph

 (:leader

   :desc "Org Pomodoro"              "P" #'org-pomodoro

   (:prefix "o"
     :desc "Ielm"                    "i" #'ielm)

   (:prefix "p"
     :desc "Kill project buffers"    "k" #'doom/kill-project-buffers)

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

 (:after company
   (:map company-active-map
     [tab] nil
     "TAB" nil))

 (:after yasnippet
   (:map yas-keymap
     [tab] #'yas-next-field
     "TAB" #'yas-next-field))

 (:after flycheck
   (:map flycheck-mode-map
     "M-n" #'flycheck-next-error
     "M-p" #'flycheck-previous-error))

 (:after pdf-view
   (:map pdf-view-mode-map
     "q" nil
     "Q" nil))

 (:after projectile
   (:map projectile-command-map
     "f"   #'projectile-find-file
     "4 f" #'projectile-find-file-other-window
     "F"   #'projectile-find-file-in-known-projects
     "4 F" #'+projectile-find-file-in-known-projects-other-window
     "s"   #'+ivy/project-search
     "S"   #'+ivy/project-search-from-cwd)))
