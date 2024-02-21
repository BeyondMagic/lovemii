#!/usr/bin/env nu
#
# BeyondMagic © João Farias 2024 <beyondmagic@mail.ru>

const default_playlist = 'https://www.youtube.com/playlist?list=PLZx2EchsfnlgoXkZtHaNrAta_hIl4wkXA'
const default_archive = '~/armazenamento/música/youtube.log'
const default_folder = '~/armazenamento/música/canções/'
const default_format = '%(title)s.%(ext)s'
const default_max = 50

# Add cover to image.
export module cover {

	# FIXIT: find covers for us and shit.
	export def download [
		song : string
		author : string
	] -> nothing {
	}

	# FIXIT: make parameter and shit.
	export def set [
		file : string
		video : string
	] -> nothing {
		^ffmpeg ...[
			-i $video
			-i $file
			-map 0:0
			-map 1:0
			-c copy
			-id3v2_version 3
			-metadata:s:v title='Album cover'
			-metadata:s:v comment='Cover (front)'
			new-"$2"
		]
	}
}

# Download all songs from a playlist.
#
# Dependes on:
#	- yt-dlp : https://github.com/yt-dlp/yt-dlp
export def download [
	playlist : string = $default_playlist # Playlist link to download from.
	--archive : string = $default_archive # Archive to save all files.
	--folder : string = $default_folder # Folder to save files in.
	--format : string = $default_format # Format of files. See yt-dlp help page.
	--max : int = $default_max # Max videos to download from most updated.
] -> nothing {

	# Download the new songs to the folder.
	^yt-dlp ...[
		-o ($folder | path join $format)
		--download-archive $archive
		--add-metadata
		--embed-thumbnail
		--embed-metadata
		--embed-chapters
		--no-embed-info-json
		--sub-langs 'all'
		--embed-subs
		--playlist-end $max
		--metadata-from-title "(?P<artist>.+?) - (?P<title>.+)"
		-x
		-i $playlist
	]
		
}

# Update database with new songs.
export def update [] -> nothing {
	# Add the new songs to the MPD database.
	mpc update --wait
}
