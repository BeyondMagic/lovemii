#!/usr/bin/env nu
#
# João Farias © BeyondMagic 2024 <beyondmagic@mail.ru>

# Return a random item of the given data.
export def item [] {
	let piped = $in
	if ($piped | is-empty) {
		error make {
			msg: "Failed to find data.",
			label: {
				text: "Not given any data.",
				span: (metadata $piped).span
			}
		}
	}
	$piped | get (random int 0..($piped | length))
}
