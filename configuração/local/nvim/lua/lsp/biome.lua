-- local util = require 'lspconfig.util'

require'lspconfig'.biome.setup {
	-- cmd = "biome",
    -- filetypes = {
    --   'javascript',
    --   'javascriptreact',
    --   'typescript',
    --   'typescriptreact',
    --   'json'
    -- },
	-- root_dir = util.root_pattern('rome.json'),
    single_file_support = true,
    on_attach = function(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, bufnr)
      end
    end,
  capabilities = CAPABILITIES,
}
