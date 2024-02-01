#!/usr/bin/env nu
#
# BeyondMagic © João Farias 2024 <beyondmagic@mail.ru>

# Download videos
export def download [
	name? : string # Name of the file.
	--archive : string = './archive.txt' # Archive file.
] -> nothing {
	let file_name = if ($name | is-empty) {
		(date now | format date '%y-%m-%d_%H_%M_%S') + '_unnamed'
	} else {
		$name
	}
	
	let piped = $in
	let link = if ($piped | is-empty) { wl-paste } else { $piped }

	yt-dlp ...[
		--download-archive $archive
		--add-metadata
		--embed-thumbnail
		--embed-metadata
		--embed-chapters
		--sub-langs 'all'
		--embed-subs
		-i
		-f
		'bestvideo[height<=1080]+bestaudio'
		$link
		-o $name
	]
}
