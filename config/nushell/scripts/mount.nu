#!/usr/bin/env nu
#
# BeyondMagic © João Farias 2024 <beyondmagic@mail.ru>

use nnn.nu

# Return list of disks.
def get_disks [] -> list<string> {
	ls --long /dev/disk/by-id | get target | each {|disk|
		'/dev/' + ($disk | str substring 6..)
	} | reverse
}

# Mount a partition into /mnt/pendrive/.
export def pendrive [
	partition : string@get_disks # Partition to mount.
] {
	let result = do {
		^doas -- mount -o umask=0,uid=nobody,gid=nobody $partition /mnt/pendrive
	} | complete

	if $result.exit_code == 0 {
		n '/mnt/pendrive/'
	}
}

# Return list of mountpoints that rae not SWAP or empty.
def get_mountpoints [] -> list<string> {
	^lsblk --json | from json | get blockdevices | par-each {|disk|
		mut mountpoints = $disk.mountpoints

		if not ($disk | get --ignore-errors children | is-empty) {
			$mountpoints = ($mountpoints | append ($disk.children.mountpoints | flatten))
		}

		$mountpoints | filter {|disk| not ($disk | is-empty) or ($disk == '[SWAP]')}
	} | flatten
}

# Remove mountpoint.
export def remove [
	mountpoint : string@get_mountpoints # Partition to mount.
] -> nothing {
	^doas -- umount $mountpoint
}
