require 'lspconfig'.elixirls.setup {
	-- Unix
	cmd = { "elixir-ls" },

	capabilities = CAPABILITIES,

	flags = {
		debounce_text_changes = 150,
	},
	elixirLS = {
		dialyzerEnabled = false,
		fetchDeps = false,
	}
}
