#!/usr/bin/env sh

# 1. The current bit code of the tag.
current_tag="$(dwm-msg get_monitors | jq '.[].tagset.current')"

# 2. Increase bit by one.
next_tag="$(($current_tag << 1))"

# 3. Go to the tag.
dwm-msg run_command view $next_tag
