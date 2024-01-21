#!/usr/bin/env nu
#
# My desktop manager!
#
# João Farias © BeyondMagic <beyondmagic@mail.ru> 2021-2024

use std log

# Kill all processes of the user launching the process.
export def clear [] -> int {
	pkill -U (whoami)
}

# Execute the compositor.
export def --env main [] -> int {
	log debug "Hyprland is being started."
	exec Hyprland
}