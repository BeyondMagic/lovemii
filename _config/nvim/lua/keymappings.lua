----------------------------Less words----------------------------

local key = vim.api.nvim_set_keymap

---------------------------Leader Keys---------------------------

-- Set with normal Vim opts, 'Space' as mapleader
vim.g.mapleader = ' '

-- Set 'Space' as <NOP> key to leadermap key
key('n', '<Space>', '<NOP>', { noremap = true, silent = true })


---------------------------Visual Block-------------------------

key('n', '<Leader>v', 'vv<C-v>', { noremap = true, silent = true })

---------------------------Telescope (fuzzy finder fil)-------------------------

-- Find all TODOs and comments
key('n', '<Leader>l', ':TodoTelescope<CR>', { noremap = true, silent = true })
-- Using lua functions
key('n', '<Leader>ff', ':lua require("telescope.builtin").find_files()<cr>', { noremap = true, silent = true })
key('n', '<Leader>fg', ':lua require("telescope.builtin").live_grep()<cr>', { noremap = true, silent = true })
key('n', '-', ':-', { noremap = true, silent = true })
key('n', '+', ':+', { noremap = true, silent = true })
key('n', '<C-Down>', 'g%', { noremap = true, silent = true })
key('n', '<C-Up>', 'z%', { noremap = true, silent = true })

---------------------------Tab auto-complete-------------------------

-- key('i', '<TAB>', '<C-n>', { noremap = true, silent = true })
-- key('i', '<S-TAB>', '<C-p>', { noremap = true, silent = true })
-- key('i', '<CR>', 'pumvisible() ? "\\<C-y>" : "\\<CR>"', { expr = true, noremap = true, silent = true })

-- Do nothing on CTRL + Home
key('i', '<C-End>', '<End>', { noremap = true, silent = true })
key('n', '<C-End>', '<End>', { noremap = true, silent = true })
key('i', '<C-Home>','<End>', { noremap = true, silent = true })


---------------------------Window Movement----------------------------

-- Set '<Leader>h' as 'help search' command
key('i', '<A-TAB>', '<ESC>:tabNext<CR>', { noremap = true, silent = true  })
key('n', '<A-TAB>', ':tabNext<CR>', { noremap = true, silent = true  })
key('n', '<TAB>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
key('n', '<S-TAB>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
key('n', '<Leader>x', ':bd<CR>', { noremap = true, silent = true })
key('n', '<Leader>X', ':bd<CR>', { noremap = true, silent = true })
key('n', '<C-d>', ':bd<CR>', { noremap = true, silent = true })
key('i', '<C-r>', '<ESC>ui', { noremap = true, silent = true })
key('n', '<C-r>', 'u', { noremap = true, silent = true })

---------------------------Explorer Keys-------------------------



key('n', '<Leader>qq', ':q<CR>', { noremap = true, silent = true })
key('n', '<Leader>h', ':set hlsearch!<CR>', { noremap = true, silent = true })

-- Set '<Leader>e' as 'explorer' command, open and close
key('n', '<Leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
key('n', '<Leader>z', ':ZenMode<CR>', { noremap = true, silent = true })
key('n', '<Leader>t', ':Twilight<CR>', { noremap = true, silent = true })
key('n', '<Leader>n', ':NnnPicker %:p:h<CR>', { noremap = true, silent = true })


-------------------------------Spell--------------------------------


key('i', '<C-b>', 'ea<C-x><C-s>', { noremap = true, silent = true  })
key('n', '<F5>', ':setlocal spell!<CR>', { noremap = true, silent = true  })


---------------------------Better Movement-----------------------------

-- Move lines normally like an IDE when line wraps
key('i', '<Down>', '<c-\\><c-o>gj', { noremap = true, silent = true  })
key('i', '<Up>', '<c-\\><c-o>gk', { noremap = true, silent = true  })

-- Delete character and go to Insert mode when BACKSPACE on Normal Mode
--key('n', '<BS>', 'i<BS>', { noremap = true, silent = true })
-- Create new line and go to Insert mode when ENTER on Normal Mode
--key('n', '<CR>', 'i<CR>', { noremap = true, silent = true })

---------------------------------Search-----------------------------------

-- Disable or enable highlight by pressing 'CTRL + c'
key('n', '<C-c>', ':if (&hlsearch == 1) | set nohlsearch | else | set hlsearch | endif<cr>', { noremap = true, silent = true  })

---------------------------Insert normal tab------------------------

--key('i', '<C-i>', '		', { noremap = true, silent = true  })

---------------------------Paste, Copy, Select------------------------

-- Set 'CTRL + v' as 'paster'
-- key('', '<C-v>', 'map"_d<Esc>i', { noremap = true, silent = true  })
key('i', '<C-v>', '<Esc>mapa', { noremap = true, silent = true  })
key('v', '<C-v>', '"_dPi', { noremap = true, silent = true  })

-- Set 'CTRL + x' as 'cut'
key('v', '<C-x>', 'mad`ai<Right>', {  silent = true  })

-- Set 'CTRL + c' as 'copier'
key('v', '<C-c>', 'may`ai', { noremap = true, silent = true  })
key('i', '<C-v>', '<Esc>mapa', { noremap = true, silent = true  })

-- Set 'CTRL + z' as 'undo'
key('i', '<C-z>', '<Esc>ui', { noremap = true, silent = true  })

-- SEt 'CTRL + y' as 'redo'
key('i', '<C-y>', '<Esc><C-r>', { noremap = true, silent = true  })

-- Set 'SHIFT + arrows/special-keys' as 'select'
key('v', '<S-Up>', '<Up>', { noremap = true, silent = true  })
key('v', '<S-Down>', '<Down>', { noremap = true, silent = true  })
key('v', '<S-Left>', '<Left>', { noremap = true, silent = true  })
key('v', '<S-Right>', '<Right>', { noremap = true, silent = true  })
key('n', '<S-Up>', 'v<Up>', { noremap = true, silent = true  })
key('n', '<S-Down>', 'v<Down>', { noremap = true, silent = true  })
key('n', '<S-Left>', 'v<Left>', { noremap = true, silent = true  })
key('n', '<S-Right>', 'v<Right>', { noremap = true, silent = true  })
key('i', '<S-Up>', '<Esc>v<Up>', { noremap = true, silent = true  })
key('i', '<S-Down>', '<Esc>v<Down>', { noremap = true, silent = true  })
key('i', '<S-Left>', '<Esc>v<Left>', { noremap = true, silent = true  })
key('i', '<S-Right>', '<Esc>v<Right>', { noremap = true, silent = true  })

-- Set 'SHIFT + special-keys' as 'select'
key('i', '<S-Home>', '<Esc>v<Home>', { noremap = true, silent = true  })
key('i', '<S-End>', '<Esc>v<End>', { noremap = true, silent = true  })
key('n', '<S-Home>', '<Esc>v<Home>', { noremap = true, silent = true  })
key('n', '<S-End>', '<Esc>v<End><Left>', { noremap = true, silent = true  })
key('n', '<S-PageUp>', '<Esc>:call Visual_Scroll_Up()<CR>i<Right><Left>', { noremap = true, silent = true  })
key('n', '<S-PageDown>', '<Esc>:call Visual_Scroll_Down()<CR>i<Right><Left>', { noremap = true, silent = true  })
key('i', '<PageUp>', '<Esc>:call Insert_Scroll_Up()<CR>i', { noremap = true, silent = true  })
key('i', '<PageDown>', '<Esc>:call Insert_Scroll_Down()<CR>i', { noremap = true, silent = true  })
key('i', '<S-PageUp>', '<Esc>:call Visual_Scroll_Up()<CR>i<Right><Left>', { noremap = true, silent = true  })
key('i', '<S-PageDown>', '<Esc>:call Visual_Scroll_Down()<CR>i<Right><Left>', { noremap = true, silent = true  })

-- Special seleect for visual mode
key('v', '<', '<gv', { noremap = true, silent = true  })
key('v', '>', '>gv', { noremap = true, silent = true  })


-- Set 'Backspace' as 'delete selection' in Visual mode
key('v', '<BS>', '"_di', { noremap = true, silent = true  })

-- Set 'F36 + F35' as 'delete word' in Insert mode, specific for my build of Simple Terminal (suckless)
key('i', '<F36><F35>', '<C-w>', { noremap = true, silent = true  })


