#!/usr/bin/env sh

PATH_SUSPEND_FIFO="/tmp/is_suspended"

[ -f "$PATH_SUSPEND_FIFO" ] && {
  is_suspend="Resume: continue recording." 
} || {
  is_suspend="Pause: suspend recording."
}

option="$(echo "Stop: end recording.\n$is_suspend" | 91menu -g 0x0+1250+33 | sed -r 's/:.+//')"

case $option in

  Pause)

    pacmd set-source-mute 0 1
    kill -STOP $(pgrep -f "ffmpeg -f alsa -ac 1 -i pulse -f x11grab -r 30 -s ")
    touch "$PATH_SUSPEND_FIFO"

  ;;

  Resume)

    pacmd set-source-mute 0 0
    kill -CONT $(pgrep -f "ffmpeg -f alsa -ac 1 -i pulse -f x11grab -r 30 -s ")
    rm "$PATH_SUSPEND_FIFO"

  ;;

  Stop)

    pacmd set-source-mute 0 0
    kill -CONT $(pgrep -f "ffmpeg -f alsa -ac 1 -i pulse -f x11grab -r 30 -s ")
    record_size 'stop'

  ;;

esac
