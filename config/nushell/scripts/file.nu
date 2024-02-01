#!/usr/bin/env nu
#
# BeyondMagic © João Farias 2024 <beyondmagic@mail.ru>

# Content manager.
export module content {

	# Copy the content of the file into the Wayland clipboard.
	# Needs wl-copy.
	export def copy [
		name: string # File name.
	] -> nothing {
		open --raw $name | wl-copy
	}

	# Copy the last content of the clipboard into a file.
	export def paste [
		name: string # File name.
		--force = false # Save even if it exists.
	] -> nothing {
		if $force {
			wl-paste | save --force $name
		} else {
			wl-paste | save $name
		}
	}

}

# Path manager.
export module path {

	# Copy the file path of the file.
	export def copy [
		name: string # File name
	] -> void {
		$name | path expand | wl-copy
	}

}
