#!/usr/bin/env nu
#
# BeyondMagic © João Farias 2024 <beyondmagic@mail.ru>

const default_database = '~/armazenamento/rotina.json'

# TODO: Generalise this function.
# Get task names.
def get_name_tasks [context: string] -> list<string> {
	# Transform into a list of arguments, trim the ones with spaces, remove the ones that are empty, and take the last.
	# Because we need only valid arguments.
	mut possible_database_path = ($context | split row ' ' | filter {|element| not ($element | str trim | is-empty)} | last)

	mut database = $default_database

	# If path exists, change the default to this one.
	if ($possible_database_path | path exists) {
		$database = $possible_database_path
	}

	# Return only names of groups.
	(open $database).tasks.name | par-each {|name| '"' + $name + '"' }
}

# Each task will have as unique identifies its name, so doesn't allow repetitive task names.
export module task {
	# Make an empty or not defined variable error.
	def raise_error [
		name: string # Name of the variable.
		span: record<start: int, end: int> # Span to create error from.
	] -> nothing {
		error make {
			msg: $'($name) empty or not defined.'
			label: {
				text: $'--($name) was not given a value.'
				span: $span
			}
		}
	}

	# Delete task of routine.
	export def delete [
		name : string # Name of the task, be short and concise.
		--database : string = $default_database # Database path.
	] -> nothing {

		mut data = open $database.

		# If task does not exist, raise error.
		if ($data.tasks | where name == $name | is-empty) {
			error make {
				msg: "Cannot found name in database."
				label: {
					text: "This task does not exist."
					span: (metadata $name).span
				}
			}
		}

		$data.tasks = ($data.tasks | where name != $name)

		$data | save --force $database
	}

	# Create task to routine.
	export def create [
		--name : string # Name of the task, be short and concise.
		--duration : duration # Duration of the task.
		--description : string # Description of the task, be coherent.
		--tags : list<string> # Tags to be added for the task.
		--database : string = $default_database # Database path.
		--add_tags = true # Add non-existent tags automatically.
	] -> nothing {
		if ($name | is-empty) {
			raise_error 'name' (metadata $name).span
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

		if ($duration | is-empty) {
			raise_error 'duration' (metadata $duration).span
		}

		if $add_tags {
			$data.tags = ($data.tags | append $tags | uniq)
		} else {
			let tag_name = $data.tags | wrap 'name'
			$data.tag | par-each {|tag|
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

	# Display tasks.
	export def main [
		--database : string = $default_database # Database path.
	] {
		open $database | get tasks | par-each {|data|
			mut task = $data
			$task.duration = ($task.duration | into duration)
			$task
		}
	}
}

use task

# Each group will have as unique identifies its name, so doesn't allow repetitive group names.
export module group {

	# Raise error with non existent goup.
	def raise_error [
		span: record<start: int, end: int> # Span to create error from.
		exists # Whether group exists or not.
	] -> nothing {
		if $exists {
			error make {
				msg: "Existent group was given."
				label: {
					text: "Group already exists."
					span: $span
				}
			}
		}
		error make {
			msg: "Non-existent group was given."
			label: {
				text: "Group does not exist."
				span: $span
			}
		}
	}

	# Get group name list.
	def get_name_groups [context: string] {
		# Transform into a list of arguments, trim the ones with spaces, remove the ones that are empty, and take the last.
		# Because we need only valid arguments.
		mut possible_database_path = ($context | split row ' ' | filter {|element| not ($element | str trim | is-empty)} | last)

		mut database = $default_database

		# If path exists, change the default to this one.
		if ($possible_database_path | path exists) {
			$database = $possible_database_path
		}

		# Return only names of groups.
		(open $database).groups.name
	}

	# Delete group from routine.
	export def delete [
		name : string # Name of the group.
		--database : string = $default_database # Database path.
	] {
		mut data = (open $database)

		if ($data.groups | where name == $name | is-empty) {
			raise_error (metadata $name).span false
		}

		$data.groups = ($data.groups | filter {|group| $group.name != $name})
		
		$data | save --force $database
	}

	# Create and add new group to routine.
	export def create [
		name : string # Name of the group.
		--database : string = $default_database # Database path.
	] {
		mut data = (open $database)

		if not ($data.groups | where name == $name | is-empty) {
			raise_error (metadata $name).span true
		}

		$data.groups = ($data.groups | append {
			'name': $name
			'tasks': []
		})

		$data | save --force $database
	}

	# Add task to specific group.
	export def add [
		group : string@get_name_groups # Group to add.
		--task : string@get_name_tasks # Task to add (required.)
		--at : int = -1 # Which index to put at.
		--database : string = $default_database # Database path.
	] {
		# Raise error if not found task variable.
		if ($task | is-empty) {
			error make {
				msg: "Task was not given."
				label: {
					text: "--task not defined."
					span: (metadata $task).span
				}
			}
		}

		mut data = (open $database)

		# Raise error if group does not exist.
		if ($data.groups | where name == $group | is-empty) {
			raise_error (metadata $group).span false
		}

		# Raise error if not found task name.
		if ($data.tasks | where name == $task | is-empty) {
			error make {
				msg: "Invalid task was given."
				label: {
					text: "Task does not exist."
					span: (metadata $task).span
				}
			}
		}

		# Length of tasks.
		let m = $data.groups | where name == $group | length

		# Define index.
		let i = if $at > 0 { $at mod $m } else {($m + $at mod $m) - 1}

		# Update specific group by adding to it the given task.
		$data.groups = ($data.groups | par-each {|element|
			if $element.name == $group {
				mut changed = $element
				$changed.tasks = ($changed.tasks | insert $i $task)
				return $changed
			}
			$element
		})

		$data | save --force $database
	}

	# Display group tasks.
	export def main [
		name?: string@get_name_groups # Name of the group.
		--database : string = $default_database # Database path.
	] {
		let tasks_expanded = task
		let groups = (open $database).groups | par-each {|data|
			mut group = $data
			$group.tasks = ($group.tasks | par-each {|task_name|
				$tasks_expanded | where name == $task_name
			})
			$group
		}

		# When not given group name, return all groups.
		if ($name | is-empty) {
			return $groups
		}

		# Get the data of the group.
		let data = ($groups | where name == $name)

		# If empty, raise error.
		if ($data | is-empty) {
			raise_error (metadata $name).span false
		}

		$data.0
	}
}

use group

# Tasks of today.
export def today [
	--database : string = $default_database # Database path.
] {
	let day = (date now | format date '%A' | str downcase)
	group $day --database $database
}

# Delete routine database.
export def delete [
	--database : string = $default_database # Database path.
] {
	rm $database
}

# Create database.
export def main [
	--database : string = $default_database # Database path.
] -> int {
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
	} | save $database
}
