# Launch the default editor specified by $env.EDITOR.
export def main [
	...args: string # Arguments to launch along with it.
] -> nothing {
	^$env.EDITOR ...$args
}
