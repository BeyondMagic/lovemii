#!/usr/bin/env sh
#
# -- Will update the main colours of EWW windows.
#
# Note: This needs two arguments:
#       1. The name of the variable
#       2. The colour of the variable.
#
# BeyondMagic © 2022 <koetemagie@gmail.com>

# -- Variables.
file="$HOME/.config/eww/scss/automatic.scss"

# -- Test arguments.
[ ! "$1" ] || [ ! "$2" ] && exit 1

# -- Main operation.
sed \
  -i \
  -re "s/^"'\$'"$1.*/"'\$'"$1 : $2;/g" \
  "$file"
