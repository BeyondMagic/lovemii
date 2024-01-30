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
		--tags : list<string> # Tags to be added for the task.
		--database : string = $default_database # Where it is guarded.
		--add_tags = true # Add non-existent tags automatically.
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

		if $add_tags {
			$data.tags = ($data.tags | append $tags | uniq)
		} else {
			let tag_name = $data.tags | wrap 'name'
			$data.tag | each {|tag|
				if ($tag_name | where name == $tag | is-empty) {
					error make {
						msg: "Non-existent tag was given."
						label: {
							text: $'Tag ($tag) does not exist.',
							span: (metadata $tag).span
						}
					}
				}
			}
		}

		$data.tasks = ($data.tasks | append {
			'name': $name
			'description': $description
			'duration': $duration
			'tags': $tags
		})
		$data | save --force $database
	}
}

# Create database.
export def main [
	--database : string = $default_database # Where it is guarded.
] {
	{
		'tags': []
		'tasks': []
		'groups': [
			{
				'name': 'sunday'
				'tasks': []
			}
			{
				'name': 'monday'
				'tasks': []
			}
			{
				'name': 'tuesday'
				'tasks': []
			}
			{
				'name': 'wednesday'
				'tasks': []
			}
			{
				'name': 'thursday'
				'tasks': []
			}
			{
				'name': 'friday'
				'tasks': []
			}
			{
				'name': 'saturday'
				'tasks': []
			}
		]
	}| save $database
}
