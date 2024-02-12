#!/usr/bin/env nu
#
# BeyondMagic © João Farias 2024 <beyondmagic@mail.ru>

const default_database = [
	'~/armazenamento/citações.json'
]

# Add quote to database.
export def add [
	...words : string # The words
	--author : list<string> # Author(s) of the quote.
	--source : list<string> # Source(s) of the quote.
	--time : datetime # When quote was made.
	--database : string # The database to load from.
] -> nothing {

	if ($database | describe) == nothing or not ($database | path exists) {
		error make {
			msg: "--database failed parsing."
			label: {
				text: "Empty or path does not exist."
				span: (metadata $database).span
			}
		}
	}

	if ($words | is-empty) {
		error make {
			msg: "Empty quote given."
			label: {
				text: "Is empty."
				span: (metadata $words).span
			}
		}
	}

	{
		words: $words
		author: $author
		source: $source
		date: {
			added: (date now)
			time: $time
		}
	} ++ (open $database) | save --force $database
}

# Initialise database.
export def setup [
	database: list<string> = $default_database # The database(s) to load from.
] -> nothing {
	$database | par-each {|path|
		[] | save $path
	}
}

# List all quotes of databases.
export def main [
	database: list<string> = $default_database # The database(s) to load from.
] -> list<any> {
	$default_database | par-each {|path|
		open $path
	} | flatten
}
