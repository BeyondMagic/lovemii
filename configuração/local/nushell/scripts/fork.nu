# Spawn closure command(s) in the background and return PID.
#
# Examples:
#	> fork "echo lol" "exec /usr/bin/sleep 10" --stdout /home/dream/stdout --stderr /home/dream/stderr
#	> const name = "cat"
#	> fork $"notify-call ($name) meaw"
#   > fork { notify-call $name }
#
# Will launch into default POSIX shell first then redirect all output (stderr and stdout) to $log while self-executing into nushell nohup'd.
export def main [
	commands: any, # The commands to run.
	--stdout: string = '/dev/null', # Redirect stdout to file.
	--stderr: string = '/dev/null' # Redirect stderr to file.
	--sh: string = 'sh' # Shell to execute the commands.
] -> int {
	let type = $commands | describe

	let source_code = if $type == 'closure' {
		view source $commands | str substring 2..-2
	} else {
		($commands | str join '; ') + ';'
	}

	do {
		sh -c -- $"exec nohup ($sh) -c \"($source_code)\" 1> ($stdout) 2> ($stderr) & echo $!"
	} | complete | get stdout
}
