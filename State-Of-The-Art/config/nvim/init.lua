-- Global, windows options of neovim:
require('options')

-- Filetype specialties.
require('filetype')

-- LSP for editing.
require('lsp')

-- Packer Plugin to adminstrate packages:
--   git clone https://github.com/wbthomason/packer.nvim\
--   ~/.local/share/nvim/site/pack/paker/start/packer.nvim
require('plugins')

-- Autocmd commands from Vimscript
require('autocmd')

-- Personal Keymaps of neovim:
require('keymappings')

-- Hai there!
--print('|> Welcome my fellow friend 🌎')
