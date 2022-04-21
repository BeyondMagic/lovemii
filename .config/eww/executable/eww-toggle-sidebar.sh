#!/usr/bin/env sh
#
# João F. © BeyondMagic 2022 <koetemagie@gmail.com>

if [ "$1" = 'open' ]; then

  eww update menu_is_open=true && eww open-many menu-central

else

  eww close menu-central && eww update menu_is_open=false

fi
