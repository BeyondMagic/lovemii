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

