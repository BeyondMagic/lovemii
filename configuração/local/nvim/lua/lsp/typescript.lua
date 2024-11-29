require 'lspconfig'.ts_ls.setup {

	settings = {
		implicitProjectConfiguration = {
			checkJs = true
		},
	},

	capabilities = CAPABILITIES,

	on_attach = function(client, bufnr)

		if client.server_capabilities.documentSymbolProvider then
			require("nvim-navic").attach(client, bufnr)
		end

	end
}
