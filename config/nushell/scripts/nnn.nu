# Run nnn with dynamic changing directory to the environment.
export def --env n [...x] {
	# Launch nnn. Add desired flags after `^nnn`, ex: `^nnn -eda ($x | str join)`
	^nnn -radDoRJU -T t ($x | str join)
	let newpath = (
		if ($env.NNN_TMPFILE | path exists) {
			# FIXME: fails if path contains single-quote
			let newpath = (open $env.NNN_TMPFILE | parse "cd '{nnnpath}'").0.nnnpath
			^rm -f $env.NNN_TMPFILE
			echo $newpath
		} else {
			pwd
		}
	)
	cd $newpath
}
