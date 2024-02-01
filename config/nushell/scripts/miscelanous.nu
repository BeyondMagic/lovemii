#!/usr/bin/env nu
#
# BeyondMagic © João Farias 2024 <beyondmagic@mail.ru>

# Copies the actual path for clipboard.
export def cpdir [
	file: string = './' # Path to copy.
] -> nothing {
	$file | path expand | wl-copy
}

# Function to take last clipboard into an image.
export def to_image [
	name: string # File name.
	--type : string = 'png' # Type extension file.
	--force = false # Force save.
] -> nothing {
	if $force {
		wl-paste | save ($name + '.' + $type)
	} else {
		wl-paste | save ($name + '.' + $type)
	}
}
