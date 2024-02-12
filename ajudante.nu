#!/usr/bin/env nu
#
# João Farias © BeyondMagic 2024 <beyondmagic@mail.ru>

use log.nu

def link_debug [
	de: string # O caminho para ligar.
	para: string # Onde lingar.
] -> nothing {
	log debug --name "lovemii" --format "Fazendo ligamento\nDe:   %s\nPara: %s" $de $para
}

def link [
	de: string # O caminho para ligar.
	para: string # Onde ligar.
	--administrador = false # Se é preciso de permissões administrativas.
] -> nothing {
	if $administrador {
		^doas ln ...[
			--symbolic
			--force
			--no-target-directory
			$de
			$para
		]

	} else {
		^ln ...[
			--symbolic
			--force
			--no-target-directory
			$de
			$para
		]
	}
}

# Link all files 
export def ligar [
] -> nothing {

	let dados = open dados.json
	if not ($dados.ligações.administrador | is-empty) {
		print "Asking administrative permissions."
		^doas true
	}

	let ligações = (($dados.ligações.local | par-each {|item|
		mut ligação = $item
		$ligação.administrador = false
		$ligação
	}) | append ($dados.ligações.administrador | par-each {|item|
		mut ligação = $item
		$ligação.administrador = true
		$ligação
	}))

	$ligações | par-each {|ligação|
		
		let tipo = ($ligação.de | describe)

		# Uma pasta, onde todos os arquivos presentes serão ligados.
		if $tipo == 'string' {

			# Se for pasta, pegar o nome dos arquivos na pasta.
			let arquivos = if $ligação.único {
				[ $ligação.de ]
			} else {
				ls $ligação.de | get name
			}

			$arquivos | par-each {|de|

				let de_expandido = ($de | path expand)
				let para_completo = if $ligação.único {
					($ligação.para | path dirname | path expand) + '/' + ($ligação.para | path basename)
				} else {
					($ligação.para | path expand) + '/' + ($de | path basename)
				}

				link --administrador $ligação.administrador $de_expandido $para_completo
			}


		# Lista de arquivos individuais a serem ligados.
		} else if $tipo == 'list<string>' {
			$ligação.de | par-each {|arquivo|
				let de_expandido = ($arquivo | path expand)
				let para_expandido = if $ligação.único {
					($ligação.para)
				} else {
					($ligação.para | path dirname | path expand | path join '/') + ($ligação.para | path basename) + '/' + ($arquivo | path basename)
				}

				link --administrador $ligação.administrador $de_expandido $para_expandido
			}

		} else if $tipo == 'record<pasta: string, exclusão: string>' {
			mkdir ($ligação.para | path expand)

			ls --all $ligação.de.pasta | get name | par-each {|pasta|
				ls $pasta | get name | par-each {|arquivo|
					if not $arquivo ends-with $ligação.de.exclusão {
						return $arquivo
					}
					null
				}
			} | par-each {|grupo|
				let serviço_pasta = ($ligação.para | path join ($grupo | first | path dirname | path basename)) | path expand
				mkdir $serviço_pasta
				
				$grupo | par-each {|arquivo|
					let de_expandido = ($arquivo | path expand)
					let para_expandido = ($ligação.para | path expand | path join ($arquivo | path dirname | path basename) | path join ($arquivo | path basename))

					link $de_expandido $para_expandido
				}
			}
		}
	}

	null
}

export def main [
] -> nothing {
}
