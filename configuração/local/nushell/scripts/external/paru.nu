# Install packages in system.
export def install [
	...packages: string # Names of the packages.
]: nothing -> nothing {
	main [
		-S
		...$packages
	]
}

# Just get the names themselves.
def "nu-complete old-packages" []: string -> list<string> {
	$in
	null

	ls /var/cache/pacman/pkg/*.zst
	| get name
}

# Downgrade package.
export def downgrade [
	package: string@'nu-complete old-packages' # Version and name of the package.
]: nothing -> any {
	main [
		-U
		$package
	]
}

# Remove all packages.
export def remove [
	...packages: string # Names of the packages.
]: nothing -> nothing {
	main [ -R ...$packages ]
}

# List files of a package.
export def list-paths [
	...packages: string # Name of the package.
	--long = true # Get all available columns for each entry (slower; columns are platform-dependent).
]: nothing -> table<any> {

	$packages | par-each {|package|
		let files = main [
			-Ql $package
		] | lines | par-each {|item|
			let data = $item
				| split row ' '
			
			ls --long=$long --directory $data.1
			| first
		}

		{
			name : $package
			files : $files
		}
	}
}

# List all packages of the system.
export def list []: nothing -> any {
	main [ -Q ]
	| detect columns --no-headers
	| rename 'name' 'version'
}

# Clean all packages old files from the system.
export def clean []: nothing -> any {
	main [ -Scc ]
}

# Upgrade all packages.
export def upgrade [
	--ignore: list<string> # Names of packages to ignore.
	--refresh = true # Refresh packages database.
	--force-refresh = false # Force-refrsh database.
] : nothing -> nothing {
	mut args = [ -Su ]

	if $force_refresh {
		$args = $args ++ [ -yy ]
	} else if $refresh {
		$args = $args ++ [ -y ]
	}

	if not ($ignore | is-empty) {
		let ignore_parsed = $ignore
			| par-each {
				[ --ignore ] ++ [ $in ]
			}
			| flatten

		$args = $args ++ $ignore_parsed
	}

	main $args
}

# The command itself for the package manager.
# See paru manual(1).
#
# Paru is a package manager that follows Arch package protocols.
def main [
	arguments: list<string> # Arguments to pass for it.
]: nothing -> any {
	^paru ...$arguments
}
