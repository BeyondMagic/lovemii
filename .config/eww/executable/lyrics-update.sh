#!/usr/bin/env sh
#
# João F. © BeyondMagic 2022 <koetemagie@gmail.com>

alias eu='eww update'
alias h='head -n1'

# Update title.
eu lyrics-title="$(mpc -f "[%title%]" | h)" &

# Update artist.
eu lyrics-artist="$(mpc -f "[%artist%]" | h)" &

# Update time.
eu lyrics-time="$(mpc -f "[%time%]" | h)" &

# Update lyrics.
eu lyrics-lyrics="$(mpd-lyrics-song)" &
