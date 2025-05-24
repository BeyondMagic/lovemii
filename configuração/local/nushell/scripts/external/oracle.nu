use fork.nu

# Run Oracle SQL Developer with appropriate environment variables set.
export def sql-developer []: nothing -> any {
	$env.JAVA_HOME = '/usr/lib/jvm/openjdk-zulu17-ca-fx-bin/'
	$env.LANG = 'en_GB.UTF-8'

	fork { exec oracle-sqldeveloper }
}
