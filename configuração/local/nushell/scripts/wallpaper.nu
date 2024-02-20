#!/usr/bin/env nu
#
# BeyondMagic © João Farias 2024 <beyondmagic@mail.ru>

const default_folder = "~/armazenamento/imagens/paredepapel/desktop/**/*"

# Set wallpaper using wallpaper manager.
export def set [
	file : string # Wallpaper file.
] -> nothing {
	^swww img $file --transition-type any
}

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
