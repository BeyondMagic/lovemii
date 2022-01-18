#!/usr/bin/env sh
#
# Dependencies:
#   eww
#   dwm (IPC patch applied)
#   jq
#   dunstify
#   xgetres
#   xnotify
#   zsh
#
# BeyondMagic UNLICENSE https://github.com/beyondmagic/magiCK/

# As the name says, it will wait for a TAG change of DWM and give the new values.
dwm_tag_change() {

  dwm-msg --ignore-reply subscribe tag_change_event \
    | jq --unbuffered '.tag_change_event.new_state.selected , .tag_change_event.new_state.occupied'

}

# A local function to shout out a tag name based on their IDs, you can change it to whatever
# you want to or just remove it completelly.
get_name_of_tag() {

  # Icon of each tag based on XRESOURCES variables.
  case $selected in
    1)   name="$(xgetres bars.name0)" ;;
    2)   name="$(xgetres bars.name1)" ;;
    4)   name="$(xgetres bars.name2)" ;;
    8)   name="$(xgetres bars.name3)" ;;
    16)  name="$(xgetres bars.name4)" ;;
    32)  name="$(xgetres bars.name5)" ;;
    64)  name="$(xgetres bars.name6)" ;;
    128) name="$(xgetres bars.name7)" ;;
    256) name="$(xgetres bars.name8)" ;;
    511) name="$(xgetres bars.name9)" ;;
  esac

  # Send a notification to XNOTIFY FIFO.
  # HACK: using zsh echo built-in to read the UNICODE UTF-32BE characters. No idea how to change this.
  zsh -c "echo -ne '$(printf "$name" | sed -r 's/U\w{8}/\\&/g')'" > "$XNOTIFY_FIFO" &

}

# To see if it will show the next tag sign on EWW.
set_next_tag () {

   # If it's the last tag, don't set.
   [ $name = 'nine' ] && unset noadd || noadd="true"

}

# Main loop.
dwm_tag_change | while IFS=$'\n' read -r selected && read -r occupied; do

  set noadd

  # Loop through all the 9 tags.
  tag=0; while [ $tag -le 8 ]; do

    # Name to use for EWW variables update.
    # Such as "tag-one".
    case $tag in
      0) name="one"   ;;
      1) name="two"   ;;
      2) name="three" ;;
      3) name="four"  ;;
      4) name="five"  ;;
      5) name="six"   ;;
      6) name="seven" ;;
      7) name="eight" ;;
      8) name="nine"  ;;
    esac

    # Move bits to match the TAG ID.
    bit=$((1 << $tag))

    # Selected TAG and with programs.
    if   [ $(($selected & $bit)) -ne 0 ] && [ $(($occupied & $bit)) -ne 0 ]; then

      eww update "tag-class-$name"="chosen-occupied"
      eww update "tag-$name"=true
      set_next_tag

    # Selected TAG without programs.
    elif [ $(($selected & $bit)) -ne 0 ]; then

      eww update "tag-class-$name"="chosen"
      eww update "tag-$name"=true
      unset noadd

    # Not selected TAG with programs.
    elif [ $(($occupied & $bit)) -ne 0 ]; then

      eww update "tag-$name"=true
      eww update "tag-class-$name"="not-chosen"
      set_next_tag

    # Not selected TAG without programs.
    else

      eww update "tag-$name"=false

    fi

  tag=$((tag+1)); done

  # If we can see the next sign tag.
  [ $noadd ] && eww update tag-add=true \
             || eww update tag-add=false

  # If the last select is the same as the one right now, then give a qucik notification.
  [ "$last_selected" = "$selected" ] || {

    # XNOTIFY notification.
    get_name_of_tag "$selected" &

  }

  # Define last selected to be used on the next tag change so that we don't run this again unnecessarily.
  last_selected="$selected"

done

# If dwm-msg or dwm is killed.
open="$(dunstify -u 2 "tags: dwm-msg is gone" "Perhaps it is because dwm died. To reset: middle click on this notification." -A "A,N")"

# Executes this script itself if action handler is received.
[ "$open" = "A" ] && exec "$HOME/.config/eww/bars/bottom/dwm_tags_daemon.sh"
