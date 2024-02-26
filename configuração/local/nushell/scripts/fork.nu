# Spawn closure command(s) in the background and return PID.
#
# Dependencies:
#	sh
#	nohup
#
# Will launch into default POSIX shell first then redirect all output (stderr and stdout) to $log while self-executing into nushell nohup'd.
export def main [
	command: closure, # The commands to run.
	--stdout: string = '/dev/null', # Redirect stdout to file.
	--stderr: string = '/dev/null' # Redirect stderr to file.
] -> int {
	let source_code = view source $command
		| str replace --all `"` `\"`
		| str substring 2..-2
	# ^ Escape double quotes for POSIX shell.
	# ^ Remove the `{ ` and ` }` from source of command.
	
	# Spawner of the process.
	let command = [
		# Fork the spawner.
		exec nohup
		# Use chosen shell to execute the given command.
		nu --commands
		# Escape the command using double quotes.
		('"' + $source_code + '"')
		# Send standard output and error streams to chosen files.
		# Uses POSIX syntax.
		'1>' $stdout '2>' $stderr
		# Print the PID.
		& echo '$!'
	]
	| str join ' '

	^sh -c -- $command
	| into int
}
