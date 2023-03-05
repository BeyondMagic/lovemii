#!/usr/bin/env sh
#
# Will update EWW variables about the current weather in a specific location.
#
# Note: The text being formatted is:
#       GoogleWeather Celsius 23
#       GoogleWeather Fahrenheit 74
#       GoogleWeather Location ...
#       GoogleWeather DayTime 19:00 (金曜日)
#       GoogleWeather Climate ところにより曇
#       GoogleWeather Rain 降水確率: 1%
#       GoogleWeather Humidity 湿度: 49%
#       GoogleWeather WindKM 10 km/h
#       GoogleWeather WindMPH 6 mph
#       GoogleWeather Image ...
#
# BeyondMagic © 2021-2022

# ---------------
# -- Variables.
# ---------------

# The folder where all icons will be guarded after being downloaded.
icons="$HOME/.local/share/icons/onebox"

# The city and the unit of federation (state, region, etc).
place='gama brasilia'

# The language iris will serach in, also alter the catch word for "temperature".
language='fr'
word='temperature'

# The interval to reset to get new results of the weather
time='30m'

# -------------
# -- Aliases
# -------------

alias eu='eww update'

# --------------
# -- Functions
# --------------

# 1. Catch only the line.
retrieve_line() { echo "$content" | sed -n "$1p "; }

# 2. Will download the image in case it's not found.
retrieve_image() {

  # Change the size in the link of the icon to its max, 256x256.
  link="$(echo "$(retrieve_line $1)" | sed 's_/64/_/256/_')"

  # Name of the icon.
  image="$icons/$(echo "$link" | sed -r 's_.*\/__g')"

  # If the image hasn't been downloaded yet.
  [ -f "$image" ] || curl "$link" --create-dirs -o "$image"

  # Use the image.
  echo "$image"

}

# --------------------
# -- Main operations
# --------------------

while :; do

  # -- Catche the content from iris.
  content="$(LANG=fr \
    iris "#word $place" \
    | awk '$1 == "GoogleWeather" { $1="";$2=""; print substr($0,3) }')"

  # -- Update the content of EWW.

  # Display Celsius.
  eu 'weather-celsius'="$(retrieve_line 1)"

  # Display Fahrenheit
  #eu 'weather-fahrenheit'="$(retrieve_line 2)"

  # Shows full location.
  #eu 'weather-location'="$(retrieve_line 3)"

  # The day and time of last update.
  #eu 'weather-day-update'="$(retrieve_line 4)"

  # Label of the climate.
  eu 'weather-climate-label'="$(retrieve_line 5)"

  # Chance of rain.
  #eu 'weather-rain'="$(retrieve_line 6)"

  # Humidity of climate.
  #eu 'weather-climate'="$(retrieve_line 7)"

  # Wind speed in Km.
  #eu 'weather-wind-km-'="$(retrieve_line 8)"

  # Wind speed in Mph.
  #eu 'weather-wind-mph'="$(retrieve_line 9)"

  # Path of the icon and image.
  eu 'weather-image-path'="$(retrieve_image 10)"

  sleep "$time"

done
