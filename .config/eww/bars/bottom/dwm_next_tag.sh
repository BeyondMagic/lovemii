#!/usr/bin/env sh

current_tag="$(dwm-msg get_monitors | jq '.[].tagset.current')"
next_tag="$(($current_tag << 1))"
dwm-msg run_command view $next_tag
