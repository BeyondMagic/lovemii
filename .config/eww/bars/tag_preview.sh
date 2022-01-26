#!/usr/bin/env sh

exit 0

# Socket path.
socket="$1.socket"

# Geometry of nsxiv.
geometry="480x300+15+560"

# nsxiv call.
preview="nsxiv -N preview -T preview -g"

# killer of the same previewer call.
k () { pkill -f "$preview .+ "; }

c () { pgrep -f "$preview" -c; }

# If it's called only to kill.
[ "$3" = 'kill' ] && {

  # Remove socket.
  rm -f /tmp/*.socket

  # Kill the previewr.
  k

  sleep 0.5s

  k

  # Exit the program.
  exit 0

}

# If there's already a previwer running with the same path.
# If there's a previewr already running.
[ -f "$socket" ] || [ "$(c)" -gt 0 ] && {

  # Remove socket.
  rm -f /tmp/*.socket

  # Kill the previewr.
  k

}

{

  # Start the program
  touch "$socket"

  # Just show the preview after 1s.
  sleep 0.5s

  # See if FIFO still exists.
  [ "$(c)" -gt 0 ] && {

    rm -f "$socket"
    k
    exit 0

  }

  # Kill the previewer.
  k

  # Test if argument and file exists.
  # [ -f "$1" ] || exit 1

  # Open the previewer on nsxiv.
  $preview $geometry $1

  # Remove socket.
  rm -f /tmp/*.socket

}
