#!/usr/bin/env sh
#
# DEPENDENCIES:
#   eww
#   mpd
#   mpc
#   notify-call
#
# BeyondMagic UNLICENSE https://github.com/beyondmagic/magiCK/

# Update overall EWW.
eww_update () {

  mpd-notify-song

}

# To ge the current state of MPD.
# Possible values are "playing" and "paused".
mpd_state () { mpc status '%state%'; }

# To verify when the player comes back playing.
last_state="$(mpd_state)"

# To verify when a song changes.
last_name="$(mpc current)"

# Initial setup, will run once, it will get the current state of MPD and update to the correct value.
[ "$last_state" = 'playing' ] && eww update reveal-songnames=true

# Loop MPD state changes, it gives two outputs, one of the server itself, another from the player.
while true ; do

  mpc idle

  # MPD is paused.
  if [ "$(mpd_state)" = 'paused' ]; then

    # Disable EWW running the other script.
    eww update reveal-songnames=false &

    # To verify later if the song was paused.
    last_state='paused'

  # MPD is playing.
  else

    new_song="$(mpc current)"

    # Song changed.
    [ "$last_name" != "$new_song" ] && {

      last_name="$new_song"
      eww_update &

    }

    # If the last state was not playing.
    [ "$last_state" = "paused" ] && {

      eww_update &
      last_state='playing'

    }

    # Quick update of value and allow EWW to run the other script.
    eww update reveal-songnames=false
    eww update reveal-songnames=true &

  fi

done

# If dwm-msg or dwm is killed.
open="$(notify-call \
          -d 'echo A' \
          'EWW' \
          'Do you want to reset the EWW script for MPD songs?')"

# Executes this script itself if action handler is received.
[ "$open" = "A" ] && exec "$0"
