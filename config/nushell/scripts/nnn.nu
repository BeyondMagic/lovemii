#!/usr/bin/env nu
#
# BeyondMagic © João Farias 2024 <beyondmagic@mail.ru>

# Run nnn with dynamic changing directory to the environment.
export def --env n [
	...flags : string # Extra flags to launch nnn with.
] -> nothing {

	let config_home = if ($env.XDG_CONFIG_HOME | is-empty) {
		$'($env.HOME)/.config/'
	} else {
		$env.XDG_CONFIG_HOME
	}

	# The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set).
	let nnn_tmpfile = $config_home + '/nnn/.lastd'

	# Launch nnn. Add desired flags after `^nnn`, ex: `^nnn -eda ($x | str join)`
	NNN_TMPFILE=$nnn_tmpfile ^nnn -radDoRJU -T t ...$flags

	if ($nnn_tmpfile | path exists) {
		# Remove <cd '> from the first part of the string and the last single quote <'>.
		# Fix post-processing of nnn with path, escaping single quotes with POSIX syntax.
		let path = (open $nnn_tmpfile | str substring 4..-1 | str replace --all `'\''` `'`)

		rm $nnn_tmpfile

		cd $path
	}
}
