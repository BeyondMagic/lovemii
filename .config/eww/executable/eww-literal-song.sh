#!/usr/bin/env sh

format() { sed -r 's_\&__g'; };

{

  # 0. Get current playlist.
  playlist="$(mpc playlist)"

  # 1. Get current song's name.
  song_center_index="$(mpc status %songpos%)"
  song_center="$(echo "$playlist" | sed -n "${song_center_index}p" | format)"

  # 2. Get previous song's name.
  song_left_index=$((song_center_index - 1))
  song_left="$(echo "$playlist" | sed -n "${song_left_index}p" | format)"

  # 3. Get next song's name.
  song_right_index=$((song_center_index + 1))
  song_right="$(echo "$playlist" | sed -n "${song_right_index}p" | format)"

  # If on single mode. Don't show the next and left.
  [ "$(mpc status %single%)" = 'on' ] && unset song_right song_left

}

{

  # 1. Get the number of characters of the song's name.
  song_length=${#song_center}

  # 2. Parse the info to get the progress in %
  percentage_run=$(mpc status '%percenttime%' | sed -r 's/^ +|%$//g')

  # 3. Transform into the porcentage of the total song.
  percentage_total=$(awk -v n="$song_length" -v m="$percentage_run" 'BEGIN{ print int( n*(m/100)) }')

  # 4. 
  song_center_highlight="$(expr substr "$song_center" 1  $percentage_total)"
  song_center_normal="$(expr substr "$song_center" $(($percentage_total + 1)) $song_length)"

}

# 1. Left
colour="$(xgetres eww.top-bar.song.left)"
song_left="<span color='$colour'>$song_left</span>"

# 1. Center.
colour_hi="$(xgetres eww.top-bar.song.center.highlight)"
colour="$(xgetres eww.top-bar.song.center)"
song_center="<span color='$colour_hi'>${song_center_highlight}</span><span color='$colour'>${song_center_normal}</span>"

# 2. Right
colour="$(xgetres eww.top-bar.song.right)"
song_right="<span color='$colour'>$song_right</span>"

eww update top-bar-song-left="$song_left" &
eww update top-bar-song-center="$song_center" &
eww update top-bar-song-right="$song_right" &

echo "$song_left"
echo "$song_center"
echo "$song_right"
