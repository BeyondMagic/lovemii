# `paru` is a command for Arch-linux based distributions.
export use ./external/paru.nu *

def update-system []: nothing -> any {
	use ./external/magick.nu
	upgrade
	magick link
}

export alias upgrade = update-system
