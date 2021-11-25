-- Personal global, windows options of neovim:
require('options')

-- Packer Plugin to adminstrate packages:
--   git clone https://github.com/wbthomason/packer.nvim\
--   ~/.local/share/nvim/site/pack/paker/start/packer.nvim
require('plugins')

-- Personal Keymaps of neovim:
require('keymappings')

-- LSP Lua (build from source without telemetry (use grep to find config)
-- 	https://github.com/sumneko/lua-language-server
-- 	cd lua-language-server
-- Then change the path to your 'lua-language-server' build
require('lsp.lua-ls')

-- C++ and C Language Server
require('lsp.ccls')

-- Typescript + Javascript Language Server
require('lspconfig').tsserver.setup{}

-- CSS + Less + SASS Language Server
require('lsp.cssls')

-- Autocmd commands from Vimscript
require('autocg')

-- Global function
require('default.functions')

-- Themes for my neovim
-- require('theme')

-- Hai there!
print('-- Welcome my fellow friend :)')
