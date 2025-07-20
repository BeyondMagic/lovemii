#!/usr/bin/env -S nu --stdin

const special_workspace = 'minimized'

export def main [
	flags?: string # Flags to pass to the program when opening it.
	--type: string # Type of action to perform: 'open', 'show', 'toggle', or 'minimize'.
	--class: string # Class of the program to minimize.
]: nothing -> any {

	let has_program = (
		^hyprctl
		clients -j	
	)
	| from json
	| where { $in.class == $class }
	| is-not-empty

	let type = if $type == 'toggle' {
		if $has_program {

			let workspace = (
				^hyprctl clients -j 
			)
			| from json
			| where { $in.class == 'thunderbird' }
			| get 0.workspace.id

			if $workspace <= 0 {
				'show'
			} else {
				'minimize'
			}
		} else {
			'open'
		}
	} else {
		$type
	}

	print ($type)

	if $type == 'open' and not $has_program {

		let flags = if ($flags | is-empty) {
			''
		} else {
			$flags
			| str trim
		}

		exec $class $flags

	} else if $type == 'minimize' {

		(
			^hyprctl
			dispatch
			movetoworkspacesilent
			$"special:($special_workspace),class:($class)"
		)

	} else if $type == 'show' or ($type == 'open' and $has_program) {

		let workspace = (
			^hyprctl
			activeworkspace -j
		)
		| from json
		| get id

		(
			^hyprctl
			dispatch
			movetoworkspacesilent
			$"($workspace),class:($class)"
		)

		(
			^hyprctl
			dispatch
			focuswindow
			$"class:($class)"
		)

	} else {
		error make {msg: $"unknown type: ($type)" }
	}
}
