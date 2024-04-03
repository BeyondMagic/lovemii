#!/usr/bin/env nu
#
# BeyondMagic © João Farias 2024 <beyondmagic@mail.ru>

# Extract name from file.
def extract-name []: string -> string {
	$in
	| path basename
	| split row '.'
	| drop 1
	| get 0
}

# Convert video MKV to MP4.
export def mkv-to-mp4 [
	input: string # Video MKV to convert.
	output: string # Video MP4 made.
]: nothing -> nothing {
	^ffmpeg -i $input -c:a aac -c:v copy $output
}

# Convert video to MP3.
export def to-mp3 [
	input: string # Video to convert.
]: nothing -> nothing {
	let out = $input
		| extract-name

	^ffmpeg -i $input -q:a 0 -map a ($out + '.webp')
}

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

# Make subvideo from start to end.
#
# Examples:
#	$ video subvideo `a.mkv` --start 00:00:01 --end 00:00:10
export def subvideo [
	file : string # Input file for video as path.
	--start : string # Start time stamp of the video in format HH:MM:SS.MSE.
	--end : string # End time stamp of the video in format HH:MM:SS.MSE.
	--output : string # Output file for video as path.
] : nothing -> nothing {

	# Raise error when start timestamp is not given.
	if ($start | is-empty) {
		error make {
			msg: "Not given start time stamp."
		}
	}

	# Raise error when end timestamp is not given.
	if ($end | is-empty) {
		error make {
			msg: "Not given end time stamp."
		}
	}

	let out = if ($output | is-empty) {

		# Get extension of file.
		let extension = $file
			| split row '.'
			| last

		# Make new output path with random chars.
		($file
			| str substring ..(
				$file | str index-of '.' --end
		)) + '-' + (
			random chars --length 3
		) + '.' + $extension
	} else {
		$output
	}

	main [
		-ss $start
		-i $file
		-c copy
		-to $end
		$out
	]
}

const default_video_flags = [
	-c copy
	-map 0
	-reset_timestamps 1
]

# Split video by different segments with a duration.
#
# Dependes on:
#	- ffmpeg
#
# Input path of file is piped in standard input.
#
# Examples:
#	> 'video.mp4' | video split 2min new_video.mp4
#
# Read more information about flags in ffmpeg manual(s).
export def split [
	segment : duration # Duration of each segment.
	out : string # Name of file to save in.
	--flags : list<string> = $default_video_flags # Flags for ffmpeg.
	--segment-format : string = '-%03d' # Specifier of each segmented video.
	--extension : string # If not specified, will default to that of the file.
] -> nothing {
	let piped = $in

	if not ($piped | path exists) or ($piped | path type) != 'file' {
		error make {
			msg: "Failed to parse input."
			label: {
				text: "Is not a file or does not exist."
				span: (metadata $piped).span
			}
		}
	}

	let micro_seconds = (($segment | into int) / 1000) | into string

	let type = if ($extension | describe) == nothing {
		$piped | split row '.' | last
	} else {
		$extension
	}

	main [
		-i $piped
		...$flags
		-segment_time ($micro_seconds + 'us')
		-f segment
		($out + $segment_format + '.' + $type)
	]
}

# The main comand used for video.
def main [
	args : list<any> # Arguments to be given for the main command.
] : nothing -> nothing {
	^ffmpeg ...$args
}
