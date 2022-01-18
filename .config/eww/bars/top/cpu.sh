#!/usr/bin/env sh

set number icon class

number=$(sensors | sed -r -e 's/edge: +\+|.0°C//g' -e '5q;d')

# -∞ < ... <= 35
if   [ $number -le 35 ]; then

  icon=""
  class="one"

# 35 < ... <= 40
elif [ $number -gt 35 ] && [ $number -le 40 ]; then

  icon=""
  class="two"

# 40 < ... <= 45
elif [ $number -gt 40 ] && [ $number -le 45 ]; then

  icon=""
  class="three"

# 45 < ... <= 50
elif [ $number -gt 45 ]; then

  icon=""
  class="four"

fi

  eww_icon="(label :vexpand true :valign 'fill' :class '$class icon'   :text '$icon')"
eww_number="(label :vexpand true :valign 'fill' :class '$class number' :text '$number ºC')"

echo "$eww_icon$eww_number"
