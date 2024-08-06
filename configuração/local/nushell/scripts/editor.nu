export def restore [
	...files: string # Files to launch along with it.
	--session : string = '~/.config/nvim/session.vim' # Session to recover from.
]: nothing -> nothing {
	main --flags [
		-S $session
	] ...$files
}

# Launch the default editor specified by $env.EDITOR.
export def main [
	...files : string # Files to launch along with it.
	--flags : list<string> = [] # Flags to launch with it.
]: [list<string> -> nothing, nothing -> nothing] {
	let input = $in

	let to = if ($input | is-not-empty) {
		$input
	} else {
		$files
	} | path expand

	^$env.EDITOR ...$to ...$flags
}
