-- Global, windows options of neovim:
require('options')
--
---- Filetype specialties.
require('configuration.filetype')
--
---- Packer Plugin to adminstrate packages:
----   git clone https://github.com/wbthomason/packer.nvim\
----   ~/.local/share/nvim/site/pack/paker/start/packer.nvim
require('plugins')
--
---- LSP for editing.
require('lsp')
--
---- Autocmd commands from Vimscript
require('autocmd')
--
---- Personal Keymaps of neovim:
require('keymappings')

-- Hai there!
--print('|> Welcome my fellow friend 🌎')
