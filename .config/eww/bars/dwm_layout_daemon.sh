#!/usr/bin/env sh
#
# Dependencies:
#   eww
#   dwm (IPC patch applied)
#   grep (GNU coreutils)
#   dunstify
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

    # To stdout (debug).
    # echo "New tag chosen: $tag_label"

    # Update "layout" eww variable to the new value.
    eww update layout="$tag_label"

  done

# Delay waiting dwm get back to life.
sleep 0.5s

# Try to get this back working.
dwm-msg get_monitors || {

  # If dwm-msg or dwm is killed.
  open="$(dunstify -u 2 "layout: dwm-msg is gone" "Perhaps it is because dwm died. To reset: middle click on this notification." -A "A,N")"

  [ "$open" = "A" ] || exit 0

}

# Executes this script itself if action handler is received or dwm is alive.
exec "$HOME/.config/eww/bars/dwm_layout_daemon.sh"
