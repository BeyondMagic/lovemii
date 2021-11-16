-------------------Less words-----------------------

local option = vim.api.nvim_set_option

--------------------Windows------------------------

-- Fix moving through lines 'gk' and 'gj'
vim.wo.linebreak = true

-- Show lines number (hybrid)
vim.wo.number = true
vim.wo.relativenumber = true

-- Set wrap for words
vim.wo.wrap = true

-- Always show tabs
vim.o.showtabline = 2

-- Show xtra spaces
vim.opt.list = true

-- Set wildmenu for later use
vim.o.wildmenu = true

-- Highlighting search
vim.o.hlsearch = true

-- Set ruler for better look
vim.o.ruler = true

-- No nice message
vim.o.hidden = true

-- Partial commands only in the screen
vim.o.showcmd = true

-- Match braces when inserting new ones :)
vim.o.showmatch = true

-- Cursor line
vim.o.cursorline = true
vim.wo.cursorline = true

-- Off scroll when moving through the buffer
vim.o.scrolloff = 40

-- For terminal RGB colours
vim.go.termguicolors = true

-- Colours, I believe
vim.go.t_Co = '256'
vim.go.t_ut = ''

-- Space for tabs
vim.o.laststatus = 2

-- Space for tabs
vim.o.softtabstop = 2

-- Expand tab to use spaces instead
vim.o.expandtab = true

--  Space for tabs
vim.o.tabstop = 2

-- Space for tabs
vim.bo.shiftwidth = 2

-- Space for tabs
vim.o.shiftwidth = 2

-- Format options to not create new lines with comments
vim.o.formatoptions = 'tqj'

-- Mouse working with neovim
vim.o.mouse = 'a'

-- viminfo file
-- vim.o.viminfo = vim.o.viminfo .. '~/.config/nvim/viminfo'

-- Spell language to English (UK)
vim.o.spelllang = 'en_gb'
vim.bo.spelllang = 'en_gb'

-- Columns line "limit"
-- vim.o.cc = '85'

-- Set path for better searching across the system
-- vim.o.path = vim.o.path .. '**'

-- Complete options
vim.o.completeopt = 'menuone,longest,noselect'
vim.o.shortmess = vim.o.shortmess .. 'c'

--------------------Variables-----------------


-- Variables of vim
vim.g.one_allow_italics = 1


--------------------API------------------------

-- Set clipboard to be global across the system
option('clipboard', 'unnamedplus')

-- Basic fold column
option('foldcolumn', '1')

-- Set dictionary to language spell
option('dictionary', '/usr/share/dict/words')

-- Wildignore for when opening files :0
option('wildignore', '*/tmp*/,*/node_modules/*,_site,*/__pycache__/,*/venv/*,*/target/*,*/.vim$,~$,*/.log')

-- Folding
option('foldmethod', 'expr')

-- File format for neovim reading
option('fileformat', 'unix')

-- File format for neovim reading
option('fileformat', 'unix')

-- Setting our theme set
option('background', 'dark')
vim.api.nvim_exec('colorscheme arcoiris-nvim', false)
