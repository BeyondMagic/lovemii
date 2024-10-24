require 'lspconfig'.pylsp.setup({
	on_attach = on_attach,
	settings = {
		pylsp = {
			plugins = {
				black = { enabled = true },
				isort = { enabled = true, profile = "black" },
				pycodestyle = {
					ignore = {
						'W191'
					},
				}
			},
		},
	},
})

