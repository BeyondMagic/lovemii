-- Completion for snippets.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- For context in the winbar.
local navic = require("nvim-navic")

-- LSP Lua (build from source without telemetry (use grep to find config)
--    https://github.com/sumneko/lua-language-server
--    cd lua-language-server
-- Then change the path to your 'lua-language-server' build
require('lsp.lua-ls')

-- LATEX
require('lsp.latex')

-- Parse English.
--require('lint-nv')

-- C++ and C Language Server
require('lsp.ccls')

-- Rust Language Server.
require('lsp.rust')

-- Bash Language Server
--require('lspconfig').bashls.setup({})

-- Typescript + Javascript Language Server
---require('lspconfig').tsserver.setup({})

-- SASS Language Server
--require('lspconfig').tailwindcss.setup{}

-- CSS + Less + SASS Language Server
require('lsp.cssls')

-- For everything.
--require('lspconfig').html.setup{}

local servers = { 'cssls', 'tsserver', 'html', 'bashls', 'ccls', 'rls', 'texlab', 'sumneko_lua' }

for _, lsp in ipairs(servers) do

  require('lspconfig')[lsp].setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end
    end,

  })
end
