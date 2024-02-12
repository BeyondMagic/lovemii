#!/usr/bin/env nu
#
# BeyondMagic © João Farias 2024 <beyondmagic@mail.ru>

# Download video.
#
# Dependes on:
#	- yt-dlp : https://github.com/yt-dlp/yt-dlp
#
# Examples:
#
# Will use the piped link.
#	$ 'https://www.youtube.com/watch?...' | video download
#
# Will use the current content from clipboard.
#	$ 'https://www.youtube.com/watch?...' | wl-copy
#	$ video download
export def download [
	name? : string # Name of the file.
	--archive : string = './archive.txt' # Archive file.
	--format : string = 'bestvideo[height<=1080]+bestaudio' # Format of video and audio.
] -> nothing {
	let file_name = if ($name | is-empty) {
		[]
	} else {
		[-o ((date now | format date '%y-%m-%d_%H_%M_%S') + '_' + $name)]
	}
	
	let link = ^wl-paste

	mut args = [
		--download-archive $archive
		--add-metadata
		--embed-thumbnail
		--embed-metadata
		--embed-chapters
		--sub-langs 'all'
		--embed-subs
		-i
		$link
		...$file_name
	]

	if not ($format | is-empty) {
		$args = [ -f $format ] ++ $args
	}

	^yt-dlp ...$args
}
