-- Completion for snippets.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- LSP Lua (build from source without telemetry (use grep to find config)
--    https://github.com/sumneko/lua-language-server
--    cd lua-language-server
-- Then change the path to your 'lua-language-server' build
require('lsp.lua-ls')

-- Parse English.
--require('lint-nv')

-- C++ and C Language Server
require('lsp.ccls')

-- Bash Language Server
require('lspconfig').bashls.setup{}

-- Typescript + Javascript Language Server
require('lspconfig').tsserver.setup{}

-- SASS Language Server
require('lspconfig').tailwindcss.setup{}

-- HTML Language Server
require('lspconfig').html.setup {

  -- Enable (broadcasting) snippet capability for completion
  capabilities = capabilities,

}

-- CSS + Less + SASS Language Server
require('lsp.cssls')
