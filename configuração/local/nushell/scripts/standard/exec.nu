# Just get the names themselves.
def "nu-complete exec" []: string -> list<string> {
	$env.PATH | par-each {|path|
		if ($path | path type) == 'dir' {
			ls --short-names $path
		}
	}
	| flatten
	| get name
	| sort
}

export extern main [
    executable: string@"nu-complete exec",  # the name of the remote
    ...args: string # the branch / refspec
]

