#!/usr/bin/env -S nu --stdin

def main []: string -> nothing {
	let image = $in

	if ($image | is-empty) {
		exit 1
	}

	let to = [
			'extensões/jpg'
			'extensões/png'
			'arte/extensões/jpg'
			'arte/extensões/png'
			'arte/poemas'
			'fotos'
		]
		| str join "\n"
		| fuzzel --dmenu
	
	let base = '/home/dream/compartilhado/armazenamento/imagens/'

	mv $image ($base + $to)
}
