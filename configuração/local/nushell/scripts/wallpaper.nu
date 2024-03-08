# BeyondMagic © João Farias 2024 <beyondmagic@mail.ru>

const default_folder = "~/armazenamento/imagens/paredepapel/desktop/**/*"

# List all wallpapers.
export def list [
	folder: string = $default_folder # Folder of wallpapers.
	--all = false # Return also hidden files.
]: nothing -> list<string> {
	ls --all=$all ($folder | into glob)
	| where type != dir
	| get name
}

# Set wallpaper given path.
#
# TODO:
#	- Auto complete the types for the `--transition-type` flag.
export def set [
	--transition-type : string = 'any' # In which to perform transition when setting the wallpaper.
] : string -> nothing {
	let $file = $in

	[
		img $file
		--transition-type $transition_type
	] | main
}

# Run list of command of wallpaper manager.
def main [] : list<string> -> nothing {
	let args = $in
	# See manual for swww(1).
	# The repository can be found at: https://github.com/LGFae/swww
	^swww ...$args
}
