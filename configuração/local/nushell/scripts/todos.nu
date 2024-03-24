# João Farias © BeyondMagic <beyondmagic@mail.ru> 2024

const default_database = `~/armazenamento/afazeres/geral.json`

# Set state of a todo.
export def set [
	id: int # The ID of the task.
	done # Whether done is or not.
	--database: string = $default_database # The database of the todos.
]: nothing -> table<any> {
	main $database
	| update $id {
		update done (not $in.done)
	}
	| save --force $database

	main $database
}

# Add todo to database.
export def add [
	task: string # Activity to do.
	due?: datetime # Data the entrega.
	--database: string = $default_database # The database of the todos.
]: nothing -> nothing {
	let data = open $database

	let due_timestamp = if ($due | is-not-empty) {
		($due | into string) + " -03:00"
	}

	{
		task: $task
		done: false
		due_at: $due_timestamp
		added_at: (date now)
	} ++ $data
	| save --force $database
}

# List all todos.
export def main [
	database: string = $default_database # The database of the todos.
]: nothing -> table<any> {
	open $database
	| update added_at {
		into datetime
	}
	| update due_at {
		if ($in | is-not-empty) {
			into datetime
		}
	}
	| sort-by due_at
	| sort-by done --reverse
}
