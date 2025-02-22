#!/usr/bin/env nu
#
# João V. Farias © BeyondMagic <beyondmagic@mail.ru> 2024

# Open a file or URL in the user's preferred application.
#
# This will transform user PDF file's path to a immutable user to sahre local database.
#
# Needs environment variable PDF_USER_DATABASE defined.
# Like, if the chosen user database has the home folder: `/home/hana/`,
# then define it as `hana`.
export def main [
	path: string # File or URL to open.
]: nothing -> any {

	# Transform user PDF files' path to a immutable user to share local database.
	#let path = if $path ends-with '.pdf' and $path starts-with '/home/' and ($path | path exists) {
	#	$path
	#	| path expand
	#	| split row '/'
	#	| update 2 $env.PDF_USER_DATABASE
	#	| str join '/'
	#} else {
	#	$path
	#}

	^xdg-open $path
}
