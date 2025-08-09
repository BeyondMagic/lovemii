require 'lspconfig'.nushell.setup {
	cmd = {
		"nu",
		"--include-path",
		"/home/dream/.config/nushell/scripts",
		"--include-path",
		"/home/dream/.local/share/nupm/modules/",
		"--lsp"
	},

	-- Default.
	capabilities = CAPABILITIES,
	on_attach = function(client, bufnr)
		if client.server_capabilities.documentSymbolProvider then
			require("nvim-navic").attach(client, bufnr)
		end
	end
}
