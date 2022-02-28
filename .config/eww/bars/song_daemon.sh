#!/usr/bin/env sh
#
# Dependencies:
#   eww
#   mpd
#   mpc
#   dunstify
#   ./song.sh
#
# BeyondMagic UNLICENSE https://github.com/beyondmagic/magiCK/

# Update overall EWW.
eww_update () {

  mpd_song

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
while : ; do

  mpc idle

  # MPD is paused.
  [ "$(mpd_state)" = 'paused' ] && {

    # Disable EWW running the other script.
    eww update reveal-songnames=false

    # To verify later if the song was paused.
    last_state='paused'

  # MPD is playing.
  } || {

    new_song="$(mpc current)"

    # Song changed.
    [ "$last_name" != "$new_song" ] && {

      last_name="$new_song"
      # https://github.com/BeyondMagic/creamberry/blob/master/path/mpd_song
      eww_update &

    }

    # If the last state was not playing.
    [ "$last_state" = "paused" ] && {

      # https://github.com/BeyondMagic/creamberry/blob/master/path/mpd_song
      eww_update &

      last_state='playing'

    }

    # Quick update of value and allow EWW to run the other script.
    eww update reveal-songnames=false
    eww update reveal-songnames=true

  }

done

# If dwm-msg or dwm is killed.
open="$(dunstify -u 2 "song: mpc is gone" "Perhaps it is because mpd died. To reset: middle click on this notification." -A "A,N")"

# Executes this script itself if action handler is received.
[ "$open" = "A" ] && exec "$HOME/.config/eww/bars/song_daemon.sh"
