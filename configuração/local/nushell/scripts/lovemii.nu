#!/usr/bin/env nu
#
# João Farias © BeyondMagic <beyondmagic@mail.ru> 2021-2024

# Kill all processes of the user launching the process.
export def clear []: nothing -> nothing {
	pkill -U (whoami)
}

# Execute the compositor.
export def --env main []: nothing -> nothing {
	use environment.nu

	exec Hyprland
}
