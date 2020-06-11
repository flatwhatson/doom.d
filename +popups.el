;;; ~/.doom.d/+popups.el -*- lexical-binding: t; -*-

(set-popup-rules!
  '(("^\\*info\\*$"
     :slot 2 :side left :width 83 :quit nil)
    ("^\\*ielm\\*$"
     :vslot 2 :size 0.3 :quit nil :ttl nil)
    ("^\\*Checkdoc Status\\*$"
     :vslot -2 :select ignore :quit t :ttl 0)
    ("^\\*Flycheck errors\\*$"
     :vslot -2 :select t :quit t :ttl 0)))
