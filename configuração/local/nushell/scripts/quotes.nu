#!/usr/bin/env nu
#
# BeyondMagic © João Farias 2024 <beyondmagic@mail.ru>

const default_database = '~/armazenamento/citações.json'

# Add quote to database.
export def add [
	...words : string # The words
	--author : list<string> # Author(s) of the quote.
	--source : list<string> # Source(s) of the quote.
	--time : datetime # When quote was made.
	--database : string = $default_database # The database to load from.
] -> nothing {
	if ($words | is-empty) {
		error make {
			msg: "Empty quote given"
			label: {
				text: "Is empty."
				span: (metadata $words).span
			}
		}
	}

	mut data = open $database

	$data = {
		words: $words
		author: $author
		source: $source
		date: {
			added: (date now)
			time: $time
		}
	} ++ $data

	$data | save --force $database
}

# Initialise database.
export def setup [
	database: string = $default_database # The database to load from.
] -> nothing {
	[] | save $database
}

# List all quotes.
export def main [
	database: string = $default_database # The database to load from.
] -> list<list<string>> {
	open $default_database
}
