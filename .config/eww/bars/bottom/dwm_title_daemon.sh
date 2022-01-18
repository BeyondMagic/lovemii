#!/usr/bin/env sh
#
# Dependencies:
#   eww
#   dwm (IPC modified patch applied)
#     https://www.github.com/beyondmagic/nmwm
#   grep (GNU coreutils)
#   jq
#   dunstify
#
# BeyondMagic UNLICENSE https://github.com/beyondmagic/magiCK/

# As the name says, it will wait for a title change of DWM and give the new values.
get_title_window_change () {

  dwm-msg --ignore-reply subscribe focused_title_change_event client_focus_change_event |
    grep --line-buffered -oP '((?<=new_win_id": ).*)|((?<=client_window_id": )\d*)'

}

# EWW .yuck literal transformers.
eww_title () { echo "( label :limit-width 75  :class 'title' :text \`$1\` )"; }
eww_icon  () { echo "( label                  :class 'icon'  :text \`$1\` )"; }

# Give the window icons of the current tag.
get_windows_icons () {

  # NOTE: GREP Perl doesn't support this? <echo "[match_this\nmatch_also_this]" | grep -oP '(?<=\[)(.|\n)*?(?=\])'>
  tags_windows_id="$(dwm-msg get_monitors | jq '.[].tag_clients[]')"
  tags_number="$(printf "$tags_windows_id" | wc -c)"
  selected_window="$1"

  # There isn't any windows.
  [ $tags_number = 0 ] && {

    eww update reveal-windows=false

  # There are windows.
  } || {

    eww update reveal-windows=true
    windows=""

    # Tags Windows 
    for selected in $(echo "$tags_windows_id"); do

      set class_window

      [ "$selected" = "$selected_window" ] && class_window="selected" \
                                           || class_window="not-selected"

      icon_of_this_window="$(format_active_window "$selected" "get_icon")"

      [ $icon_of_this_window ] && windows="$windows( button :class '$class_window' :onclick 'xdotool windowactivate $selected' '$icon_of_this_window' )"

    done

    eww update windows-literal="$windows"

  }
}

# Format a Process name based on XWindow ID.
format_active_window() {

  unset icon icon_display

  selected_window_id="$1"
  total="$(xprop -id $selected_window_id | grep "_NET_WM_NAME" | sed -r 's/(_NET_WM_NAME\(UTF8_STRING\) = ")|"$//g')"
  name="$(cat /proc/"$(xdotool getwindowpid $selected_window_id)"/comm)"

  # st
  case "$name" in

    st)
      icon=""
      title_program=$(echo "$total" | sed -r 's/ .*//')
      total=$(echo "$total" | sed -r 's/\w* //')

      [ "$title_program" = "xdotool" ] && unset name

      case "$total" in

        'floatst' | 'st' )

          unset name

        ;;

        * )

          case "$title_program" in
            'v' )
              icon=""
            ;;
            'mpd' )
              icon=""
              total=$(echo "$total" | sed -r "s/» *//g")
            ;;
            'nnn' )
              icon=""
            ;;
          esac

        ;;

      esac

    ;;

    brave)

      icon=""
      total="$(echo "$total" | sed -re 's/ - Brave$//')"

    ;;

    # Firefox-Developer-Edition
    GeckoMain)

      icon=""
      total=$(echo "$total" | sed -re 's/\\"/"/g' -e 's/(\[Sidebery\] )|(Mozilla Firefox)|(— Mozilla Firefox)//g')

    ;;

    # gcolor2
    gcolor2)

      icon=""

    ;;

    # nsxiv
    nsxiv)

      icon=""

    ;;

    # gimp
    gimp)

      icon=""

    ;;

    # mpv
    mpv)

      icon=""
      total="$(echo "$total" | sed -r 's/ - mpv$//')"

    ;;

    # qbittorrent
    qbittorrent)

      icon=""

    ;;

    visualboyadvanc)

      icon=""

    ;;

    zathura)

      icon=""

    ;;

    telegram-deskto)

      icon=""

    ;;

  esac

  [ "$name" ] && {

    # If there's no icon, then just prints out the name
    [ -n "$icon" ] && icon="$icon" || icon="$name"

      [ "$2" = "get_icon" ] && echo "$icon" \
                            || echo "$(eww_icon "$icon")$(eww_title "$total")"

  }

}

# Main.
get_title_window_change | while IFS=$'\n' read -r winid; do

  # In case there is no focus.
  [ $winid = "null" ] && {

    eww update reveal-title=false

  # When focused.
  } || {

    window_full="$(format_active_window $winid)"

    [ "$window_full" ] && {

      eww update title-literal="$window_full"
      eww update reveal-title=true

    } #|| {

      #eww update reveal-title=false

    #}

  }

  get_windows_icons $winid &

done

# If dwm-msg or dwm is killed.
open="$(dunstify -u 2 "title: dwm-msg is gone" "Perhaps it is because dwm died. To reset: middle click on this notification." -A "A,N")"

# Executes this script itself if action handler is received.
[ "$open" = "A" ] && exec "$HOME/.config/eww/bars/bottom/dwm_title_daemon.sh"
