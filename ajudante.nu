#!/usr/bin/env nu
#
# João Farias © BeyondMagic 2024 <beyondmagic@mail.ru>

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

# Link all files.
export def ligar [
] -> nothing {

	let dados = open dados.json

	if ($dados | get ligações.administrador | any {|it| $it == true }) {

		print "Asking for administative access using doas for linking files."
		let result = ^doas true | complete
		if $result.exit_code != 0 {
			error make {
				msg: "Linking of administative data cannot be done."
				label: {
					text: "Polkit could not elevative permissions."
					span: (metadata $result).span
				}
			}
		}
	}

	$dados.ligações | each {|ligação|
		
		let tipo = $ligação.de | describe

		# Para copiar só os arquivos de uma uma pasta.
		if $tipo == 'string' and $ligação.de ends-with '/*' {

			# Criar pasta principal do serviço.
			if $ligação.administrador {
				^doas mkdir -p ($ligação.para | path expand)
			} else {
				mkdir ($ligação.para | path expand)
			}

			# Para cada pasta, pegar suas subpastas e retornar os arquivos dentros dela.
			ls --all $ligação.de | get name | par-each {|pasta|
				ls $pasta | get name
			} | par-each {|grupo|
				let serviço_pasta = ($ligação.para | path join ($grupo | first | path dirname | path basename)) | path expand

				if $ligação.administrador {
					^doas mkdir -p $serviço_pasta
				} else {
					mkdir $serviço_pasta
				}
				
				$grupo | par-each {|arquivo|
					let de_expandido = ($arquivo | path expand)
					let para_expandido = ($ligação.para | path expand | path join ($arquivo | path dirname | path basename) | path join ($arquivo | path basename))

					link --administrador $ligação.administrador $de_expandido $para_expandido
				}
			}


		# Uma pasta, onde todos os arquivos presentes serão ligados.
		} else if $tipo == 'string' {

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
			#$ligação.de | par-each {|arquivo|
			#	let de_expandido = ($arquivo | path expand)
			#	let para_expandido = if $ligação.único {
			#		($ligação.para)
			#	} else {
			#		($ligação.para | path dirname | path expand | path join '/') + ($ligação.para | path basename) + '/' + ($arquivo | path basename)
			#	}

			#	link --administrador $ligação.administrador $de_expandido $para_expandido
			#}

		}
	}

	null
}
