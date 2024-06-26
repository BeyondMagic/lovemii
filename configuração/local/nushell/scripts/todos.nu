# João Farias © BeyondMagic <beyondmagic@mail.ru> 2024

const default = {
	sanctum : '~/armazenamento/afazeres/completado.json'
	database : `~/armazenamento/afazeres/geral.json`
}

# List all completed todos.
export def completed [
	database: string = $default.sanctum
]: nothing -> table<any> {
	main $database
}

# Set opposite done value of a todo.
export def mark [
	id: int # The ID of the task.
	--database: string = $default.database # The database of the todos.
]: nothing -> nothing {
	main $database
	| update $id {
		update done (not $in.done)
	}
	| save --force $database
}

# Remove todo from database.
export def remove [
	task: any # ID of the task.
	--database: string = $default.database # The database of the todos.
]: nothing -> nothing {
	main $database
	| drop nth $task
	| save --force $database
}

# Add todo to database.
export def add [
	task: string # Activity to do.
	due?: datetime # Data the entrega.
	--database: string = $default.database # The database of the todos.
]: nothing -> nothing {
	let data = open ($database | into glob)

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

# Move all done tasks for another database.
export def clean [
	sanctum: string = $default.sanctum # The database of the completed todos.
	--database: string = $default.database # The database of the todos.
]: nothing -> nothing {

	let data = open ($database | into glob)
	let data_sanctum = open ($sanctum | into glob)

	$data_sanctum ++ (
		$data
		| where done == true
	)
	| save --force $sanctum

	$data
	| where done == false
	| save --force $database
}

# List all todos.
export def main [
	database: string = $default.database # The database of the todos.
]: nothing -> table<any> {
	open ($database | into glob)
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
