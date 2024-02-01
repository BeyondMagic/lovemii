#!/usr/bin/env nu
#
# BeyondMagic © João Farias 2024 <beyondmagic@mail.ru>

export-env {
	let config_home = if ($env.XDG_CONFIG_HOME | is-empty) {
		$'($env.HOME)/.config/'
	} else {
		$env.XDG_CONFIG_HOME
	}

	# The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set).
	$env.NNN_TMPFILE = ($config_home + '/nnn/.lastd')
}

# Run nnn with dynamic changing directory to the environment.
export def --env n [
	...flags : string # Extra flags to launch nnn with.
] -> nothing {

	# Launch nnn. Add desired flags after `^nnn`, ex: `^nnn -eda ($x | str join)`
	^nnn -radDoRJU -T t ...$flags

	if ($env.NNN_TMPFILE | path exists) {
		# Remove <cd '> from the first part of the string and the last single quote <'>.
		let path = (open $env.NNN_TMPFILE | str substring 4..-1)

		rm $env.NNN_TMPFILE

		cd $path
	}
}
