# BeyondMagic © João Farias 2024 <beyondmagic@mail.ru>

# Copies the actual path for clipboard.
export def cpdir [
	file: string = './' # Path to copy.
]: nothing -> nothing {
	$file
	| path expand
	| ^wl-copy
}

# Function to take last clipboard into an image.
export def to-image [
	...name: string # File name.
	--type : string = 'png' # Type extension file.
	--force = false # Force save.
]: nothing -> nothing {
	let file_name = ($name | str join ' ') + '.' + $type

	^wl-paste
	| save --force=$force $file_name
}
