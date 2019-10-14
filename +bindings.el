;;; ~/.doom.d/+bindings.el -*- lexical-binding: t; -*-

(map!

 "C-x f" #'counsel-find-file
 "C-x k" #'doom/kill-this-buffer-in-all-windows
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
   :desc "Switch to previous buffer"      "SPC" (λ! (switch-to-buffer (other-buffer)))

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

   (:prefix "/"
     :desc "Search buffer"                "b" #'swiper-isearch
     :desc "Search directory"             "d" #'+ivy/project-search-from-cwd
     :desc "Search directory (all files)" "D" (λ! (+ivy/project-search-from-cwd t))
     :desc "Find file in project"         "f" #'projectile-find-file
     :desc "Search project"               "p" #'+ivy/project-search
     :desc "Search project (all files)"   "P" (λ! (+ivy/project-search t))))

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
     "Q" nil)))
