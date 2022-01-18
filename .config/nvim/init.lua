
-- Personal global, windows options of neovim:
require('options')

-- Packer Plugin to adminstrate packages:
--   git clone https://github.com/wbthomason/packer.nvim\
--   ~/.local/share/nvim/site/pack/paker/start/packer.nvim
require('plugins')

-- Inner map for editing.
--require('innermap')

-- Personal Keymaps of neovim:
require('keymappings')

-- LSP Lua (build from source without telemetry (use grep to find config)
-- 	https://github.com/sumneko/lua-language-server
-- 	cd lua-language-server
-- Then change the path to your 'lua-language-server' build
require('lsp.lua-ls')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- C++ and C Language Server
require('lsp.ccls')

-- Bash Language Server
require('lspconfig').bashls.setup{}


-- Typescript + Javascript Language Server
require('lspconfig').tsserver.setup{}

-- SASS Language Server
require('lspconfig').tailwindcss.setup{}

-- Parse English
--require('lint-nv')

-- HTML Language Server
--Enable (broadcasting) snippet capability for completion

require('lspconfig').html.setup {
  capabilities = capabilities,
}

-- CSS + Less + SASS Language Server
require('lsp.cssls')

-- Autocmd commands from Vimscript
require('autocmd')

-- Global function
require('functions')


-- Hai there!
print('-- Welcome my fellow friend :)')
