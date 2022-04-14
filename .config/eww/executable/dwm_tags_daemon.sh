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

# To see if it will show the next tag sign on EWW.
set_next_tag () {

   # If it's the last tag, don't set.
   [ $name = 'nine' ] && unset noadd \
                      || noadd='true'

}

#
update_eww() {

  # . 
  [ "$2" ] && eww update "tag-$1"="$2"

  # . 
  [ "$3" ] && eww update "tag-class-$1"="$3"

}

# Main loop.
dwm_tag_change | while IFS=$'\n' read -r selected && read -r occupied; do

  set noadd

  # Loop through all the 9 tags.
  tag=0; while [ $tag -le 8 ]; do

    # Name to use for EWW variables update.
    # Such as "tag-one".
    case $tag in
      0) name='one'   ;;
      1) name='two'   ;;
      2) name='three' ;;
      3) name='four'  ;;
      4) name='five'  ;;
      5) name='six'   ;;
      6) name='seven' ;;
      7) name='eight' ;;
      8) name='nine'  ;;
    esac

    # Move bits to match the TAG ID.
    bit=$((1 << $tag))

    # Selected TAG and with programs.
    if   [ $(($selected & $bit)) -ne 0 ] && [ $(($occupied & $bit)) -ne 0 ]; then

      update_eww $name 'true' 'chosen-occupied'
      set_next_tag

    # Selected TAG without programs.
    elif [ $(($selected & $bit)) -ne 0 ]; then

      update_eww $name 'true' 'chosen'
      unset noadd

    # Not selected TAG with programs.
    elif [ $(($occupied & $bit)) -ne 0 ]; then

      update_eww $name 'true' 'not-chosen'
      set_next_tag

    # Not selected TAG without programs.
    else

      update_eww $name 'false'

    fi

  tag=$((tag+1)); done

  # If we can see the next sign tag.
  [ $noadd ] && eww update tag-add=true \
             || eww update tag-add=false

done

# Delay waiting dwm get back to life.
sleep 0.5s

# Try to get this back working.
dwm-msg get_monitors || {

  # If dwm-msg or dwm is killed.
  open="$(notify-call \
            -d 'echo yes' \
            'EWW' \
            'Do you want to reset the EWW script for DWM tags?')"

  # .
  if [ "$open" = 'yes' ]; then

    # Executes this script itself if action handler is received or dwm is alive.
    exec "$0"

  fi

}
