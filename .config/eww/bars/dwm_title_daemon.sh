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
eww_title () {

  echo "( label :limit-width 75 :text \`$1\` )";

}
eww_icon  () { 

  echo ":style \`background-image: url(\"$HOME/.local/share/icons/$1\");\`";

}

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

    set last_one

    # Tags Windows 
    for selected in $(echo "$tags_windows_id"); do

      set class_window

      [ "$selected" = "$selected_window" ] && class_window="selected" || class_window="not-selected"

      icon_of_this_window="$(eww_icon $(format_active_window "$selected" 'get_icon') )"

      [ "$icon_of_this_window" ] && {

        this_window="( eventbox
                                :class '$class_window'
                                ( button
                                         :onclick 'xdotool windowactivate $selected'
                                         :width 16
                                         :height 16
                                         :class 'icon'
                                         $icon_of_this_window
                                )
                     )"

        [ "$class_window" = 'selected' ] && last_one="$this_window" || windows="$windows $this_window"

      }

    done

    eww update windows-literal="$windows $last_one"

  }
}

# Format a Process name based on XWindow ID.
format_active_window() {

  unset icon icon_display

  selected_window_id="$1"
  information="$(xprop -id $selected_window_id)"
  total="$(echo "$information" | grep -oP '((?<=_NET_WM_NAME\(UTF8_STRING\) = ").*(?="))')"
  name="$(cat /proc/"$(xdotool getwindowpid $selected_window_id)"/comm)"

  # st
  case "$name" in

    'st' | 'flarity' )
      icon="flarity.svg"
      title_program=$(echo "$total" | sed -r 's/ .*//')
      total=$(echo "$total" | sed -r 's/\w* //')

      [ "$title_program" = "xdotool" ] && unset name

      case "$total" in

        'float' | 'flarity' )

          unset name

        ;;

        * )

          case "$title_program" in

            'v' | 'nvim' )
              icon="neovim.png"
            ;;

            'mpd' )
              icon="ncmpcpp.svg"
              total="$(echo "$total" | sed -r "s/» *//g")"
            ;;

            'nnn' | 'n' | '~' )
              icon="nnn.png"
            ;;

          esac

        ;;

      esac

    ;;

    'brave')

      icon="brave.svg"
      total="$(echo "$total" | sed -re 's/ - Brave$//')"

    ;;

    # Firefox-Developer-Edition
    'GeckoMain' | 'firefox' )

      icon="firefox.svg"
      total=$(echo "$total" | sed -re 's/\\"/"/g' -e 's/(\[Sidebery\] )|(Mozilla Firefox)|(— Mozilla Firefox)//g')

    ;;

    # nsxiv
    'nsxiv')

      icon="nsxiv.svg"

    ;;

    # gimp
    'gimp' | 'Gimp' | 'GIMP' | 'gimp-2.10' )

      icon="gimp.svg"

    ;;

    # mpv
    'mpv')

      icon="mpv.svg"
      total="$(echo "$total" | sed -r 's/ - mpv$//')"

    ;;

    # qbittorrent
    'qbittorrent')

      icon="qbittorrent.svg"

    ;;

    'visualboyadvanc')

      icon="visualboyadvanced.svg"

    ;;

    'zathura')

      icon="zathura.svg"

    ;;

    'telegram-deskto')

      icon="telegram.svg"

    ;;

    'ymuse')

      icon="ymuse.svg"

    ;;

  esac

  [ "$name" ] && {

    # If there's no icon, then just prints out the name
    [ -n "$icon" ] && icon="$icon" || icon="$name"

      [ "$2" = "get_icon" ] && echo "$icon" \
                            || echo "$(eww_title "$total")"

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

# Delay waiting dwm get back to life.
sleep 0.5s

# Try to get this back working.
dwm-msg get_monitors || {

  # If dwm-msg or dwm is killed.
  open="$(dunstify -u 2 "title: dwm-msg is gone" "Perhaps it is because dwm died. To reset: middle click on this notification." -A "A,N")"

  [ "$open" = "A" ] || exit 0

}

# Executes this script itself if action handler is received or dwm is alive.
exec "$HOME/.config/eww/bars/dwm_title_daemon.sh"
