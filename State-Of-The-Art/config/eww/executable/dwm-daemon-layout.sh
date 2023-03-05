#!/usr/bin/env sh
#
# DEPENDENCIES:
#   eww
#   dwm (IPC patch applied)
#   grep (GNU coreutils)
#
# BeyondMagic UNLICENSE https://github.com/beyondmagic/magiCK/

# Loop through every layout change and wait for the next one :)
# Note: there is no initial value to this, the event has to occur for the value to change.
# JSON path: .layout_change_event.new_symbol.
dwm-msg --ignore-reply subscribe layout_change_event \
  | grep --line-buffered -oP '((?<=new_symbol": ").*(?=",))' \
  | while IFS=$'\n' read -r tagid; do

    # New variable, it removes " from the start and end "
    tag_label="$(echo "$tagid" | sed -r 's/^"|"$//g')"

    # Update "layout" eww variable to the new value.
    eww update layout="$tag_label"

  done

# Delay waiting dwm get back to life in case of reset.
sleep 0.5s

# Try to get this back working.
dwm-msg get_monitors || {

  # If dwm-msg or dwm is killed.
  open="$(notify-call \
            -d 'echo yes' \
            'EWW' \
            'Do you want to reset the EWW script for DWM layouts?')"

  # .
  if [ "$open" = 'yes' ]; then

    # Executes this script itself if action handler is received or dwm is alive.
    exec "$0"

  fi

}
