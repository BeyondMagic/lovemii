#!/usr/bin/env sh
#
# Will reset all scripts from this folder.
#
# BeyongMagic © 2022

# -- Kill all daemons.
for pid in $(pgrep -f "\-daemon\-"); do
  pkill -P $pid
  kill -- $pid
done

# -- Start daemons (processes).
nohup ~/.config/eww/executable/modules/picker.sh >/dev/null 2>&1 &

nohup ~/.config/eww/executable/dwm-daemon-tags.sh >/dev/null 2>&1 &
nohup ~/.config/eww/executable/dwm-daemon-layout.sh >/dev/null 2>&1 &
nohup ~/.config/eww/executable/dwm-daemon-title.sh >/dev/null 2>&1 &
#nohup ~/.config/eww/executable/mpd-daemon-song.sh >/dev/null 2>&1 &

