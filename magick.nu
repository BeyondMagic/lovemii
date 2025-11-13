# João Farias © BeyondMagic 2024 <beyondmagic@mail.ru>

def log-with [style: string, message: string]: nothing -> nothing {
	let colorized = ansi $style
	let reset = ansi 'reset'
	print $"($colorized)($message)($reset)"
}

def log-trace [message: string]: nothing -> nothing {
	log-with 'dark_gray_dimmed' $message
}

def log-info [message: string]: nothing -> nothing {
	log-with 'light_gray' $message
}

def log-step [message: string]: nothing -> nothing {
	log-with 'light_blue_bold' $message
}

def log-success [message: string]: nothing -> nothing {
	log-with 'light_green_bold' $message
}

def log-warn [message: string]: nothing -> nothing {
	log-with 'yellow_bold' $message
}

def log-error [message: string]: nothing -> nothing {
	log-with 'red_bold' $message
}

def log-detail [label: string, value: any]: nothing -> nothing {
	let label_color = ansi 'cyan_bold'
	let value_color = ansi 'light_gray'
	let reset = ansi 'reset'
	print $"($label_color)($label)($reset): ($value_color)($value)($reset)"
}

def log-section [title: string]: nothing -> nothing {
	let accent = ansi 'green_bold'
	let border = ansi 'green_dimmed'
	let reset = ansi 'reset'
	let line = '--------------------------------------------------'
	print ''
	print $"($border)($line)($reset)"
	print $"($accent)($title)($reset)"
	print $"($border)($line)($reset)"
}

def as-list [value: any]: nothing -> list<any> {
	let kind = $value | describe

	if $kind == 'nothing' {
		log-trace 'as-list: received nothing'
		[]
	} else if $kind == 'string' {
		log-trace $"as-list: wrapping single string -> ($value)"
		[ $value ]
	} else if $kind starts-with 'list<' {
		log-trace $"as-list: received list with ($value | length) items"
		$value
	} else {
		error make {
			msg: ($"Unsupported value for list coercion: ($kind)")
		}
	}
}

def ensure-directory [
	path: string
	--requires-admin = false
]: nothing -> nothing {
	let expanded = $path | path expand
	log-trace $"ensure-directory: checking ($expanded)"
	if not ($expanded | path exists) {
		if $requires_admin {
			log-step $"ensure-directory: creating with doas -> ($expanded)"
			^doas mkdir -p $expanded
		} else {
			log-step $"ensure-directory: creating -> ($expanded)"
			^mkdir -p $expanded
		}
	}
}

def link-symlink [
	source: string
	destination: string
	--requires-admin = false
]: nothing -> record {
	let expanded_source = $source | path expand --no-symlink
	let expanded_target = $destination | path expand --no-symlink
	let parent_dir = $expanded_target | path dirname
	log-step $"link-symlink: preparing link"
	log-detail 'Source' $expanded_source
	log-detail 'Target' $expanded_target

	ensure-directory --requires-admin $requires_admin $parent_dir

	let target_exists = ($expanded_target | path exists)
	let resolved_source = $expanded_source | path expand
	let resolved_target = if $target_exists {
		try { $expanded_target | path expand } catch { '' }
	} else {
		''
	}

	if $target_exists {
		if $resolved_target == $resolved_source {
			log-info 'link-symlink: target already points to the desired source; skipping'
			return {
				source: $expanded_source
				target: $expanded_target
			}
		}

		let target_type = try { $expanded_target | path type } catch { 'unknown' }

		if $target_type == 'symlink' {
			log-step $"link-symlink: removing stale symlink -> ($expanded_target)"
			if $requires_admin {
				^doas rm $expanded_target
			} else {
				^rm $expanded_target
			}
		} else if $target_type == 'file' {
			log-warn $"link-symlink: existing file at target; replacing with symlink -> ($expanded_target)"
			if $requires_admin {
				^doas rm $expanded_target
			} else {
				^rm $expanded_target
			}
		} else {
			log-warn $"link-symlink: existing non-symlink at target; manual intervention required -> ($expanded_target)"
			return {
				source: $expanded_source
				target: $expanded_target
			}
		}
	}

	let args = [
		--symbolic
		--force
		--no-target-directory
		$expanded_source
		$expanded_target
	]

	if $requires_admin {
		log-step $"link-symlink: running -> doas ln ($args | str join ' ')"
		^doas ln ...$args
	} else {
		log-step $"link-symlink: running -> ln ($args | str join ' ')"
		^ln ...$args
	}

	{
		source: $expanded_source
		target: $expanded_target
	}
}

def expand-patterns [patterns: any]: nothing -> list<string> {
	log-trace $"expand-patterns: incoming -> ($patterns)"
	let items = as-list $patterns
	mut results = []

	for pattern in $items {
		let kind = $pattern | describe
		log-detail 'Pattern kind' $kind
		if $kind == 'string' {
			log-trace $"expand-patterns: globbing -> ($pattern)"
			let matches = glob $pattern
			log-detail 'Matches found' $matches
			let expanded = $matches | each {|path| $path | path expand }
			$results = $results ++ $expanded
		} else if $kind starts-with 'list<' {
			log-trace 'expand-patterns: flattening nested list'
			$results = $results ++ (expand-patterns $pattern)
		} else {
			error make {
				msg: ($"Glob pattern must be a string. Got: ($kind)")
			}
		}
	}

	$results
}

def ensure-admin-access []: nothing -> nothing {
	log-step 'Requesting administrative privileges via doas for linking files.'
	let result = ^doas true | complete
	if $result.exit_code != 0 {
		error make {
			msg: "Unable to elevate privileges with doas."
			label: {
				text: "Administrative links were skipped because privilege escalation failed."
				span: (metadata $result).span
			}
		}
	}
}

def link-direct [
	sources: list<string>
	target_path: string
	target_mode: string
	--requires-admin = false
]: nothing -> nothing {
	log-step 'link-direct: preparing direct link'
	log-detail 'Target mode' $target_mode
	log-detail 'Target path' $target_path
	log-detail 'Sources' $sources
	if $target_mode == 'exact' {
		if ($sources | length) != 1 {
			error make {
				msg: "Exact target mode expects a single source."
			}
		}

		let source = $sources | first
		link-symlink --requires-admin $requires_admin $source $target_path
	} else if $target_mode == 'directory' {
		ensure-directory --requires-admin $requires_admin $target_path

		$sources | each {|source|
			let destination = [$target_path, ($source | path basename)] | path join
			log-step $"link-direct: linking ($source) -> ($destination)"
			link-symlink --requires-admin $requires_admin $source $destination
		}
	} else {
		error make {
			msg: ($"Unknown target mode: ($target_mode)")
		}
	}
}

def link-directory-contents [
	sources: list<string>
	target_path: string
	--requires-admin = false
]: nothing -> nothing {
	log-step 'link-directory-contents: preparing nested link'
	log-detail 'Target path' $target_path
	log-detail 'Sources' $sources
	ensure-directory --requires-admin $requires_admin $target_path

	$sources | each {|directory|
		if ($directory | path type) != 'dir' {
			error make {
				msg: ($"Link mode 'contents' expects directories. Got: ($directory)")
			}
		}

		let nested_target = [$target_path, ($directory | path basename)] | path join
		log-detail 'Nested target' $nested_target
		ensure-directory --requires-admin $requires_admin $nested_target

		expand-patterns ([$directory, '*'] | path join)
		| each {|item|
			let destination = [$nested_target, ($item | path basename)] | path join
			log-step $"link-directory-contents: linking ($item) -> ($destination)"
			link-symlink --requires-admin $requires_admin $item $destination
		}
	}
}

# List all packages to install.
export def list-packages []: nothing -> nothing {
	open ./dados.toml
	| get packages
}

# Link all files.
export def link []: nothing -> nothing {
	let previous_dir = (pwd)
	log-section 'Link execution started'
	log-detail 'Initial directory' $previous_dir

	cd ($nu.config-path | path dirname)
	cd (git root)
	log-detail 'Repo root' (pwd)

	let config = open ./dados.toml
	log-info $"link: loaded config"
	log-detail 'Entries' ($config.links.entries | length)
	let defaults = $config.links.defaults
	let entries = $config.links.entries

	let admin_required = (
		$entries
		| any {|entry|
			$entry
			| get --optional requires_admin
			| default $defaults.requires_admin
		}
	)
	log-detail 'Admin required' $admin_required

	if $admin_required {
		ensure-admin-access
	}

	$entries | each {|entry|
		log-section $"Processing target -> ($entry.target)"
		log-detail 'Raw entry' $entry
		let requires_admin = (
			$entry
			| get --optional requires_admin
			| default $defaults.requires_admin
		)
		log-detail 'Requires admin' $requires_admin

		let target_mode = (
			$entry
			| get --optional target_mode
			| default $defaults.target_mode
		)
		log-detail 'Target mode' $target_mode

		let link_mode = (
			$entry
			| get --optional link_mode
			| default $defaults.link_mode
		)
		log-detail 'Link mode' $link_mode

		let target_path = $entry.target | path expand
		log-detail 'Target path' $target_path
		let sources = expand-patterns $entry.sources
		log-detail 'Expanded sources' $sources

		if ($sources | is-empty) {
			log-warn $"No matches found for sources -> ($entry.target)"
		} else if $link_mode == 'direct' {
			link-direct --requires-admin $requires_admin $sources $target_path $target_mode
		} else if $link_mode == 'contents' {
			if $target_mode == 'exact' {
				error make {
					msg: "Link mode 'contents' requires the target to be a directory."
				}
			}

			link-directory-contents --requires-admin $requires_admin $sources $target_path
		} else {
			error make {
				msg: ($"Unknown link mode: ($link_mode)")
			}
		}
	}

	log-success 'link: finished processing entries'
	cd $previous_dir
	log-section 'Link execution finished'
	log-detail 'Restored directory' $previous_dir
}
