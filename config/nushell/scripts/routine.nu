#!/usr/bin/env nu
#
# BeyondMagic © João Farias 2024 <beyondmagic@mail.ru>

const default_database = '~/storage/routine.json'

# Make an empty or not defined variable error.
def not_found [
	name: string # Name of the variable.
	span: record<start: int, end: int> # Span to create error from.
] -> nothing {
	error make {
		msg: $"Variable empty or not defined."
		label: {
			text: $"--($name) was not given value."
			span: $span
		}
	}
}

# Each task will have as unique identifies its name, so doesn't allow repetitive task names.
export module task {
	export module group {
		export def add [
			--name : string, # Name of the group of the task.
		] -> int {
			
		}
	}

	# Add task to routine.
	export def add [
		--name : string # Name of the task, be short and concise.
		--duration : duration # Duration of the task.
		--description : string # Description of the task, be coherent.
		--groups : list<string> # Groups to be added for the task.
		--database : string = $default_database # Where it is guarded.
		--add_groups = true # Add non-existent groups automatically.
	] -> int {
		if ($name | is-empty) {
			not_found 'name' (metadata $name).span
		}
		if ($duration | is-empty) {
			not_found 'duration' (metadata $duration).span
		}

		mut data = (open $database)
		if not ($data.tasks | get name | wrap 'name' | where name == $name | is-empty) {
			error make {
				msg: "Found same name in database."
				label: {
					text: "A task has already this name."
					span: (metadata $name).span
				}
			}
		}

		if $add_groups {
			$data.groups = ($data.groups | append $groups | uniq)
		} else {
			let group_name = $data.groups | wrap 'name'
			$data.group | each {|group|
				if ($group_name | where name == $group | is-empty) {
					error make {
						msg: "Non-existent group was given."
						label: {
							text: $'Group ($group) does not exist.',
							span: (metadata $group).span
						}
					}
				}
			}
		}

		$data.tasks = ($data.tasks | append {
			'name': $name
			'description': $description
			'duration': $duration
			'groups': $groups
		})
		$data | save --force $database
	}
}

# Create database.
export def main [
	--database : string = $default_database # Where it is guarded.
] {
	{
		'groups': []
		'tasks': []
		'week': {
			'sunday': []
			'monday': []
			'tuesday': []
			'wednesday': []
			'thursday': []
			'friday': []
			'saturday': []
		}
	}| save $database
}
