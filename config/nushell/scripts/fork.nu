# Spawn nushell command(s) in the background.
#
# Will launch into default POSIX shell first then redirect all output (stderr and stdout) to $log while self-executing into nushell nohup'd.
export def main [
	command: closure,
	--stdout (-o): string = '/dev/null',
	--stderr (-e): string = '/dev/null'
] -> int {
	let source_code = (view source $command)

	do {
		sh -c -- $"exec nohup nu -c \"do ($source_code)\" 1> ($stdout) 2> ($stderr) & echo $!"
	} | complete | get stdout
}
