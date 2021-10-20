;;; ~/.doom.d/+popups.el -*- lexical-binding: t; -*-

(set-popup-rules!
  '(("^\\*info\\*"
     :slot 2 :vslot -2 :side left :width 83 :quit nil)
    ;; ("^\\*compilation\\*"
    ;;  :slot 2 :vslot -2 :side left :width 83 :quit nil)
    ("^\\*Man "
     :slot 2 :vslot -2 :side left :width 83 :quit nil)
    ("^\\*Messages\\*$"
     :slot 2 :vslot -2 :side left :width 83 :quit nil)
    ("^\\*ielm\\*$"
     :vslot 2 :size 0.3 :quit nil :ttl nil)
    ("^\\*Checkdoc Status\\*$"
     :vslot -2 :select ignore :quit t :ttl 0)
    ("^\\*Flycheck errors\\*$"
     :vslot -2 :select t :quit t :ttl 0)
    ("^\\*Undefined references for "
     :vslot -2 :select ignore :quit t :ttl 0)))
