#!/usr/bin/env nu
#
# Will edit a priviliged file without privilige.
#
# Dependencies:
# - doas (duh)
#
# AN3223 © 2022
# João Farias © 2022-2024 BeyondMagic <beyondmagic@mail.ru>

use std log

const LIMIT_TRIES = 3

def clean [temppath: string] -> null {
	rm -rf $temppath
}

def read_file [filepath: string] -> string {
	mut content = ''
	if not (do { test -r $filepath } | complete | get exit_code | into bool) {
		$content = (cat $filepath)
	} else {
		$content = (doas cat $filepath)
	}
	return $content
}

# Like sudoedit, but for doas.
#
# Every argument will be treated as a file to edit. There's no suppot for passing arguments to doas, so you can only doas root.
#
# This script is SECURIRTY SENSTIVE! Special care has been taken to correctly preserve file attributes. Please exercise CAUTION when modifyin AND using this script.
export def edit [
	...filepaths: string # File-paths to edit, either absolute or relative.
	--limit-tries: int = $LIMIT_TRIES # Limit of tries when failed password input.
] -> nothing {

	if ($filepaths | is-empty) {
		log error " Given no files to edit. Specify which files."
		return
	}

	# Exit if environment variable EDITOR is not set.
	if not 'EDITOR' in $env or $env.EDITOR == "" {
		log error " Environment variable EDITOR is not set, please set it."
		return
	}

	for $filepath in $filepaths {

		let fullpath = $filepath | path expand

		# Test if the file exists AND it is a file.
		if ($fullpath | path type) == 'file' {
			log error $" '($filepath)' is not a file or does not exist."
			return
		}

		# Exit if we can write the file.
		if (do { test -w $fullpath } | complete | get exit_code) == 0 {
			log error $" '($filepath)' is a file you can edit!"
			return
		}

		let tmp = (basename $fullpath | prepend '/tmp/' | str join)
		cd /tmp/

		try {
			read_file $fullpath | save $tmp --force
			run-external $env.EDITOR $tmp

			if (do { diff --ignore-trailing-space --brief $fullpath $tmp } | complete | get exit_code) == 0 {

				log warning " File unchanged, exiting..."

			} else {

				mut times = 0
				while $times < $LIMIT_TRIES {
					$times += 1

					let exit_code = (do { doas dd ($tmp | prepend "if=" | str join) ($fullpath | prepend "of=" | str join) } | complete | get exit_code)

					# Wrong password attempt.
					if $exit_code == 1 {
						
						if $times == $LIMIT_TRIES {
							log warning $" You failed ($LIMIT_TRIES) times, the limit, exiting..."
							break
						}
						continue

					# Forced exit.
					} else if $exit_code == -1 {
						log warning " Canceled, exiting..."
						break

					# Successful attemp.
					} else {
						log debug " Done, changes written."
						break
					}
				}

			}
		} catch {
			log debug " Caught something, exiting."
		}
		clean $tmp
		cd -
	}
}

# Run command with elevated priviliges.
#
# Will run as the default priviged user for doas (root).
#
# Dependencies:
# - doas
export def main [
	code : closure # Code to run
	--args : list<string> = [] # The arguments to be passed to the closure.
]: nothing -> nothing {
	let closure_code = view source $code

	let command = [
		# To run the closure.
		do
		# The could itself.
		$closure_code
		# Enclose each argument with double quotes.
		# NOTE: may need to escape its double quotes themselves.
		...($args | par-each {|arg| '"' + $arg + '"' })
	] | str join ' '

	# Run the elevated access command.
	^doas nu --commands $command
}
