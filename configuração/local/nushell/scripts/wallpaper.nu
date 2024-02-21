#!/usr/bin/env nu
#
# BeyondMagic © João Farias 2024 <beyondmagic@mail.ru>

const default_folder = "~/armazenamento/imagens/paredepapel/desktop/**/*"

# List all wallapers
export def main [
	folder: string = $default_folder # Folder of wallpapers.
	--all = false # Return also hidden files.
]: nothing -> list<string> {
	if $all {
		ls --all $folder | get name
	} else {
		ls $folder | get name
	}
}

# Set wallpaper using wallpaper manager.
# TODO: Auto complete the types for the `--transition-type` flag.
export def set [
	file : string # The image/video file path.
	--transition-type : string = 'any' # In which to perform transition when setting the wallpaper.
] : nothing -> nothing {
	main ...[
		img $file
		--transition-type any
	]
}

# Run command of wallpaper manager.
export def main [
	...args : string # Arguments to launch with the main command.
] : nothing -> nothing {
	# See manual for swww(1).
	# The repository can be found at: https://github.com/LGFae/swww
	^swww ...$args
}
