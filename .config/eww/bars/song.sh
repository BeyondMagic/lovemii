#!/usr/bin/env sh


# Setting defaults
set playlist before current after

limit=35

{

  playlist="$(mpc playlist)"
  current="$(mpc current)"

  # If this is 
  before="$(echo "$playlist" | grep -B1 "$current" | head -n 1)"
  after="$(mpc queued)"

  # No before? Set to the last of the playlist
  [ "$before" ] || before="$(echo "$playlist" | grep -B1 -Ps "[-$current]" | head -n 1)"

  # If this is the first song of the playlist, then just set nothing to before.
  [ "$current" = "$(echo "$playlist" | head -n1)" ] && before=""

  [ ${#current} -gt $limit ] && current="$(echo "$current" | cut -c -"$limit")..."
  [ ${#before} -gt $limit  ] && before="$(echo "$before" | cut -c -"$limit")..."
  [ ${#after} -gt $limit   ] && after="$(echo "$after" | cut -c -"$limit")..."

}

highlight () { echo "( button :class 'highlight' \`$1\`)"; }
normal    () { echo "( button :class 'normal'    \`$1\`)"; }
previous  () { echo "( button :class 'aside' :onclick 'mpc prev' \`$1\`)"; }
next      () { echo "( button :class 'aside' :onclick 'mpc next' \`$1\`)"; }

{

  song_length=${#current}

  # Parse the info to get the progress in %
   run_percentage=$(mpc status '%percenttime%' | sed -r 's/^ |%$//g')
  real_percentage=$(awk -v n="$song_length" -v m="$run_percentage" 'BEGIN{ print int( n*(m/100)) }')

  current="
    $(highlight "$(expr substr "$current" 1  $real_percentage)" )
    $(normal    "$(expr substr "$current" $(($real_percentage + 1)) $song_length)" )
  "

}

echo "$(previous "$before") $current $(next "$after")"
