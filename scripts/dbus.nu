#!/usr/bin/env -S nu --stdin
#
# João V. Farias © BeyondMagic <beyondmagic@mail.ru> 2024

export def main []: nothing -> nothing {
	let last_dbus = ls /tmp/
		| where name =~ dbus
		| sort-by modified
		| last
		| get name

	# Link the latest DBUS socket file.
	^ln -sf $last_dbus /tmp/dbus
}
