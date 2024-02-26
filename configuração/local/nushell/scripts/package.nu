# Install packages in system.
export def install [
	...packages : string # Names of the packages.
] : nothing -> nothing {
	main [ -S ...$packages ]
}

# Remove all packages.
export def remove [
	...packages : string # Names of the packages.
] : nothing -> nothing {
	main [ -R ...$packages ]
}

# List files of a package.
export def list [
	...packages : string # Name of the package.
	--long = true # Get all available columns for each entry (slower; columns are platform-dependent).
] : nothing -> nothing {

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

# Upgrade all packages.
export def upgrade [
	--ignore : list<string> # Names of packages to ignore.
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
		$args = $args ++ [ --ignore ...$ignore ]
	}

	main $args
}

# The command itself for the package manager.
# See paru manual(1).
#
# Paru is a package manager that follows Arch package protocols.
def main [
	arguments : list<string> # Arguments to pass for it.
] : nothing -> nothing {
	^paru ...$arguments
}
