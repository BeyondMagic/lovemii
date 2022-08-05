#!/usr/bin/env sh
#
# Dependencies:
#   eww
#   dwm (IPC modified patch applied)
#     https://www.github.com/beyondmagic/nmwm
#   grep (GNU coreutils)
#   jq
#   dunstify
#
# BeyondMagic UNLICENSE https://github.com/beyondmagic/magiCK/

# As the name says, it will wait for a title change of DWM and give the new values.
get_title_window_change () {

  dwm-msg --ignore-reply subscribe focused_title_change_event client_focus_change_event |
    grep --line-buffered -oP '((?<=new_win_id": ).*)|((?<=client_window_id": )\d*)'

}

# Format a Process name based on XWindow ID.
format_active_window() {

  name="$(cat /proc/"$(xdotool getwindowpid $1)"/comm)"

  [ "$name" ] && eww update title-name="$(echo "$name" | sed "s/^\b\(.\)/\u\1/g")"

  echo "$name"

}

# Main.
get_title_window_change | while IFS=$'\n' read -r winid; do

  # In case there is no focus.
  [ $winid = "null" ] && {

    eww update reveal-title=false
    eww update title-name=""
    background-effect unblur

  # When focused.
  } || {

    window_full="$(format_active_window $winid)"

  echo "$window_full"

    [ "$window_full" ] && {

      eww update title-literal="$window_full"
      eww update reveal-title=true

    } #|| {

      #eww update reveal-title=false

    #}

    background-effect blur

  }

done

# Delay waiting dwm get back to life.
sleep 0.5s

# Try to get this back working.
dwm-msg get_monitors || {

  # If dwm-msg or dwm is killed.
  open="$(notify-call \
            -d 'echo yes' \
            'EWW' \
            'Do you want to reset the EWW script for DWM title?')"

  # .
  if [ "$open" = 'yes' ]; then

    # Executes this script itself if action handler is received or dwm is alive.
    exec "$0"

  fi

}
