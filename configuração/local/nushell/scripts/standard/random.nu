# João Farias © BeyondMagic 2024 <beyondmagic@mail.ru>

# Return a random item of the given list.
export def item []: list<any> -> any {
	let piped = $in
	if ($piped | is-empty) {
		error make {
			msg: "Failed to find data."
			label: {
				text: "Not given any data."
				span: (metadata $piped).span
			}
		}
	}
	$piped
	| get (
		random int 0..(
			($piped | length) - 1
		)
	)
}
