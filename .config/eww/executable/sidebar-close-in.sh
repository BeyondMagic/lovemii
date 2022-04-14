#!/usr/bin/env sh

if [ "$1" = 'open' ]; then

  eww update menu_is_open=true && eww open-many menu-central mpd-viewer && eww open mpd-viewer-image

else

  eww close menu-central mpd-viewer mpd-viewer-image && eww update menu_is_open=false

fi