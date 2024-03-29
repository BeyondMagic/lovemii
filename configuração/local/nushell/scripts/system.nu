# Suspend the machine to disk.
export def hibernate []: nothing -> nothing {
	^loginctl hibernate
}

# Suspend the system to memory.
export def suspend []: nothing -> nothing {
	^loginctl suspend
}

# List all fonts.
export def fonts []: nothing -> table<path: string font: string> {
	^fc-list
	| lines
	| par-each {|line|
		let data = $line
			| split row --number 2 ': '

		{
			path: $data.0
			font: $data.1
		}
	}
}
