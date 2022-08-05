#!/usr/bin/env sh

icons="$HOME/.local/share/icons/onebox"

alias eu='eww update'

retrieve_line() {

  echo "$content" | sed -n "$1p"

}

# . Will download the image in case it's not found.
retrieve_image() {

  link="$(echo "$(retrieve_line $1)" | sed 's_/64/_/256/_')"

  image="$icons/$(echo "$link" | sed -r 's_.*\/__g')"

  [ -f "$image" ] || {

    curl "$link" --create-dirs -o "$image"

  }

  echo "$image"

}

while :; do

  content="$(LANG=fr iris 'temperature gama brasilia' \
    | awk '$1 == "GoogleWeather" { $1="";$2=""; print substr($0,3) }')"

  eu 'weather-celsius'="$(retrieve_line 1)"

  #eu 'weather-location'="$(retrieve_line 3)"

  eu 'weather-climate-label'="$(retrieve_line 5)"

  eu 'weather-image-path'="$(retrieve_image 10)"

  sleep 30m

done

#GoogleWeather Celsius 23
#GoogleWeather Fahrenheit 74
#GoogleWeather Location ...
#GoogleWeather DayTime 19:00 (金曜日)
#GoogleWeather Climate ところにより曇
#GoogleWeather Rain 降水確率: 1%
#GoogleWeather Humidity 湿度: 49%
#GoogleWeather WindKM 10 km/h
#GoogleWeather WindMPH 6 mph
#GoogleWeather Image ...
