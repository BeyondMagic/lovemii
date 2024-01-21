#!/usr/bin/env nu
#
# My desktop manager!
#
# João Farias © BeyondMagic <beyondmagic@mail.ru> 2021-2024

use std log

# Execute the compositor.
export def --env main [] -> int {
	log debug "Hyprland is being started."
	exec Hyprland
}
