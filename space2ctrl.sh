#!/bin/bash

# Map an unused modifier's keysym to the spacebar's keycode and make it a
# control modifier. It needs to be an existing key so that emacs won't
# spazz out when you press it. Hyper_L is a good candidate.
spare_modifier="Hyper_L"
xmodmap -e "keycode 65 = $spare_modifier"
xmodmap -e "remove mod4 = $spare_modifier" # hyper_l is mod4 by default
xmodmap -e "add Control = $spare_modifier"

# Map space to an unused keycode (to keep it around for xcape to use).
xmodmap -e "keycode any = space"

# Use xcape to cause the space bar to generate a space when tapped.
xcape -d -e "$spare_modifier=space"

# Restore key mappings on quit.
setxkbmap -layout us
