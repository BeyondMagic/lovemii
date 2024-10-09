#!/usr/bin/env -S nu --stdin
#
# João V. Farias © BeyondMagic <beyondmagic@mail.ru> 2024

export def main []: nothing -> nothing {
	let xdg = ^pidof -s xdg-desktop-portal-gtk
	
	let environ = '/proc'
		| path join $xdg
		| path join 'environ'

	let address = ^grep -z DBUS_SESSION_BUS_ADDRESS $environ
		| ^cut -d= -f2-
		| str substring ..-2

	let last_dbus = $address
		| split row ','
		| split row '='
		| get 1

	$env.DBUS_SESSION_BUS_ADDRESS = $last_dbus

	# Link the latest DBUS socket file.
	^ln -sf $last_dbus /tmp/dbus
}
