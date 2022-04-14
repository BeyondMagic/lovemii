#!/usr/bin/env sh
#
# João F. © BeyondMagic 2022 <koetemagie@gmail.com>

# 1. Set main variables.
{

  # A. Main path of icons.
  i="IMG:$HOME/.local/share/icons"

  # B. To verify later if the recording has been suspended.
  PATH_SUSPEND_FIFO='/tmp/is_suspended'

}

_stop () {

  # A. Set Pulseaudio source of audio.
  pacmd set-source-mute 0 $1

  # B. Set new status for the recording (ffmpeg).
  kill -$2 $(pgrep -f "ffmpeg -f alsa -ac 1 -i pulse -f x11grab -r 30 -s ")

}

if [ -f "$PATH_SUSPEND_FIFO" ]; then

  is_suspend="$i/camera-plus.svg\tContinue recording\tResume"

else

  is_suspend="$i/camera-off.svg\tSuspend recording.\tPause"

fi

# 2. Retrieve command to execute.
option="$(echo "
$i/camera.svg\tEnd recording.\tStop
$is_suspend
" | sed -re '1d;$d' | xmenu -p 1200x33)"

case $option in

  Pause)

    _stop 1 STOP
    touch "$PATH_SUSPEND_FIFO"

  ;;

  Resume)

    _stop 0 CONT
    rm "$PATH_SUSPEND_FIFO"

  ;;

  Stop)

    _stop 0 CONT
    record 'stop'

  ;;

esac
