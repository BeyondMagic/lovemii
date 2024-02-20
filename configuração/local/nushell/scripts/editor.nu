# Launch the default editor specified by $env.EDITOR.
export def main [
	...files : string # Files to launch along with it.
	--flags : list<string> = [] # Flags to launch with it.
] -> nothing {
	^$env.EDITOR ...($files | path expand) ...$flags
}
