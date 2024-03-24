export-env {

	let symbol = open ~/.config/nushell/symbols.txt
		| lines
		| random item

	# The prompt indicators are environmental variables that represent
	# the state of the prompt
	$env.PROMPT_INDICATOR = {|| " > " }
	$env.PROMPT_INDICATOR_VI_INSERT = {|| ' ' + $symbol + ' ' }
	$env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
	$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }
}
