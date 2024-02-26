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
	package : string # Name of the package.
] : nothing -> nothing {
	main [
		-Ql $package
	] | lines | par-each {|item|
		let data = $item
			| split row ' '
		
		{
			name: ($data.0)
			path: (ls --directory $data.1).0
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
