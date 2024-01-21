# Helpers for the service manager.
#
# João Farias © BeyondMagic <beyondmagic@mail.ru> 2024

use environment.nu
use fork.nu

use std log

const SERVICE_MANAGER = "Service Manager"
const SERVICE_NAME = "Service"
const SERVICE_TRY_AGAIN = "Try again"
const SERVICE_RESTART = "Restart"
const SERVICE_START_AGAIN = "Start again"
const SERVICE_RUN_ONCE = "Run it"
const SERVICE_STOP = "Stop"
const SERVICE_IS_RUNNING = "is running normally."
const SERVICE_IS_NOT_RUNNING = "is not running."
const SERVICE_FAILED_START = "failed to even start!"
const SERVICE_FAILED_RUNNING = "failed while running!"
const SERVICE_SHUTDOWN = "was shutdown."
const SERVICE_RUN_FAILED = 111

# Check a service.
export def check [
	executable: string, # Basename of executable file.
	name: string        # Name of the service you want to check.
] -> int {
	let message_error = $"($SERVICE_NAME) ($name) [($executable)] ($SERVICE_IS_NOT_RUNNING)"
	let message_ok    = $"($SERVICE_NAME) ($name) [($executable)] ($SERVICE_IS_RUNNING)"

	let state = (do { sv status $executable } | complete | get stdout | split words | first)

	if $state == 'down' {
		log error $"[($SERVICE_MANAGER)] ($message_error)"
		fork $"exec notify-call --action 'sv once ($executable):($SERVICE_RUN_ONCE)' --urgency critical --app-name '($env.DESKTOP_NAME)' '($SERVICE_MANAGER)' '($message_error)'"
		exit 1
	}
	fork $"exec notify-call --urgency low --app-name '($env.DESKTOP_NAME)' '($SERVICE_MANAGER)' '($message_ok)'"
	exit 0
}

# Finish a service.
export def finish [
	number: int,        # Exit number of the service given by runsv.
	executable: string, # Basename of executable file.
	name: string        # Name of the service you want to check.
] -> int {
	let message_critical = $"($SERVICE_NAME) ($name) [($executable)] ($SERVICE_FAILED_START)"
	let message_error    = $"($SERVICE_NAME) ($name) [($executable)] ($SERVICE_FAILED_RUNNING)"
	let message_ok       = $"($SERVICE_NAME) ($name) [($executable)] ($SERVICE_SHUTDOWN)"

	if number == $SERVICE_RUN_FAILED {
		log critical $"[($SERVICE_MANAGER)] ($message_critical)."
		fork $"exec notify-call --action 'sv once ($executable):($SERVICE_TRY_AGAIN)' --urgency critical --app-name '($env.DESKTOP_NAME)' '($SERVICE_MANAGER)' '($message_critical)'"
	} else if $number != 0 {
		log error $"[($SERVICE_MANAGER)] ($message_error)."
		fork $"exec notify-call --action 'sv once ($executable):($SERVICE_RESTART)' --urgency critical --app-name '($env.DESKTOP_NAME)' '($SERVICE_MANAGER)' '($message_error)'"
	} else {
		log debug $"[($SERVICE_MANAGER)] ($message_ok)."
		fork $"exec notify-call --action 'sv once ($executable):($SERVICE_START_AGAIN)' --urgency critical --app-name '($env.DESKTOP_NAME)' '($SERVICE_MANAGER)' '($message_ok)'"
	}
	exit 0
}
