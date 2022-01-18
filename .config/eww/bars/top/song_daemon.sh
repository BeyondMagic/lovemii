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

# To ge the current state of MPD.
# Possible values are "playing" and "paused".
mpd_state () { mpc status '%state%'; }

# Initial setup, will run once, it will get the current state of MPD and update to the correct value.
[ "$(mpd_state)" = 'playing' ] && eww update reveal-songnames=true

# Loop MPD state changes, it gives two outputs, one of the server itself, another from the player.
# TODO: Do not update on seeking MPC.
mpc idleloop | while IFS=$'\n' read -r type_mpd && read -r type_mixer; do

  # Will update only on server changers.
  [ $type_mpd = 'player' ] && {

    # MPD is paused.
    [ "$(mpd_state)" = 'paused' ] && {

      # Disable EWW running the other script.
      eww update reveal-songnames=false

    # MPD is playing.
    } || {

      # https://github.com/BeyondMagic/creamberry/blob/master/path/mpd_song
      mpd_song

      # Quick update of value and allow EWW to run the other script.
      eww update reveal-songnames=false
      eww update reveal-songnames=true

    }

  }

done

# If dwm-msg or dwm is killed.
open="$(dunstify -u 2 "song: mpc is gone" "Perhaps it is because mpd died. To reset: middle click on this notification." -A "A,N")"

# Executes this script itself if action handler is received.
[ "$open" = "A" ] && exec "$HOME/.config/eww/bars/top/song_daemon.sh"
