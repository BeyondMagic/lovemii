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
	--mountable : string = '/mnt/pendrive' # Folder to mount in.
	--flags : string = 'umask=0,uid=nobody,gid=nobody' # Flags of pendrive.
] {
	mkdir $mountable
	^doas -- mount -o $flags $partition $mountable
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
