#!/usr/bin/env nu
#
# BeyondMagic © João Farias 2024 <beyondmagic@mail.ru>

const default_folder = "~/storage/images/paredepapel/"

# Set wallpaper using program.
export def set [
	file: string = # Wallpaper file.
] -> nothing {
	swww img $file --transition-type any
}

# Set a random wallpaper.
export def random [
	folder: string = $default_folder # Folder of wallpapers.
	--all = false # Get all files
	--link : string # Link file.
] -> nothing {
	let files = ls $folder

	let random_number = random int 0..(($files | length) - 1)

	let wallpaper = $files | get $random_number | get name
	set $wallpaper

	# Create hard link to chosen wallpaper file.
	if not ($link | is-empty) {
		^ln -sf $wallpaper $link
	}
}

