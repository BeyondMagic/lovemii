----------------------------Aliases----------------------------

local key = vim.api.nvim_set_keymap
local remap = { noremap = true, silent = true }

---------------------------Leader Keys---------------------------

-- Set with normal Vim opts, 'Space' as mapleader
vim.g.mapleader = ' '

-- Set 'Space' as <NOP> key to leadermap key
key('n', '<Space>', '<NOP>', remap )

-- Find recursively TODOs, NOTEs, FIXITs, ... across the root folder subfiles.
key('n', '<Leader>l', ':TodoTelescope<CR>', remap )

-- Find recursively files across the root folder subfiles.
key('n', '<Leader>ff', ':lua require("telescope.builtin").find_files()<cr>', remap )

-- Find recursively a text across the root folder subfiles.
key('n', '<Leader>fg', ':lua require("telescope.builtin").live_grep()<cr>',  remap )

-- Go to the next block.
--key('n', '<C-Down>', 'g%', remap )

-- Loop through brackets blocks.
--key('n', '<C-Up>', 'z%', remap )

-- Do just End on CTRL + End.
key('i', '<C-End>', '<End>', remap )
key('n', '<C-End>', '<End>', remap )

-- Do just Home on CTRL + Home.
key('i', '<C-Home>','<End>', remap )

-- Highlight the word after pressing enter.
key('n', '<CR>',
  [[:let searchTerm = '\v<'.expand("<cword>").'>' <bar> let @/ = searchTerm <bar> echo '/'.@/ <bar> call histadd("search", searchTerm) <bar> set hls<cr>]],
  remap )

-- Highlight the visual selection after pressing enter.
key('v', '<CR>',
[["*y:silent! let searchTerm = '\V'.substitute(escape(@*, '\/'), "\n", '\\n', "g") <bar> let @/ = searchTerm <bar> echo '/'.@/ <bar> call histadd("search", searchTerm) <bar> set hls<cr>]],
remap )

-- Highlight the visual selection after pressing '.
-- key('v', "'",
-- [[y/\V<C-R>=escape(@",'\\')<CR><CR>]],
-- remap )

-- Go to the next tab.
key('i', '<A-TAB>', '<c-o>:tabNext<CR>', remap)
key('n', '<A-TAB>', ':tabNext<CR>', remap)

-- Go to next tab (buffer).
key('n', '<TAB>', ':BufferLineCycleNext<CR>', remap )

-- Go to previous tab (buffer).
key('n', '<S-TAB>', ':BufferLineCyclePrev<CR>', remap )

-- To delete current buffer.
key('n', '<Leader>x', ':Bdelete<CR>', remap )

-- Just leave without saving.
key('n', '<Leader>qq', ':q<CR>', remap )

-- Toggle highlight of search
key('n', '<C-c>', ':set hlsearch!<CR>', remap )

-- Quick navigation between diagonostics.
key('n', '<Leader>d', ':lua vim.diagnostic.open_float()<CR>', remap )
key('n', '<Leader>N', ':lua vim.diagnostic.goto_next()<CR>', remap )
key('n', '<Leader>n', ':lua vim.diagnostic.goto_prev()<CR>', remap )

-- Toggle the sidebar tree of the root folder.
key('n', '<Leader>e', '', {

  noremap = true,
  silent  = true,
  desc    = "Open the NeoTree without any warning messages...",
  callback = function ()
    vim.o.cmdheight = 2
    vim.cmd("Neotree toggle source=filesystem position=left")
    vim.o.cmdheight = 0
  end
})

-- Writing mode with zen.
key('n', '<Leader>z', ':ZenMode<CR>', remap )

-- Close block-only highlighting mode.
key('n', '<Leader>t', ':Twilight<CR>', remap )

-- Open n³ file explorer.
-- key('n', '<Leader>n', ':NnnPicker %:p:h<CR>', remap )

-- Try to correct the current word.
key('i', '<C-b>', 'ea<C-x><C-s>', remap )

-- Toggle built-in nvim spell checking.
key('n', '<F5>', ':setlocal spell!<CR>', remap )

-- Move lines normally like an IDE when line wraps
--key('i', '<Down>', [[v:count ? 'j' : '<c-o>gj']], { expr = true, noremap = true, silent = true  })
--key('i', '<Up>',   [[v:count ? 'k' : '<c-o>gk']], { expr = true, noremap = true, silent = true  })
--key('n', '<Down>', [[v:count ? 'j' : 'gj']],      { expr = true, noremap = true, silent = true  })
--key('n', '<Up>',   [[v:count ? 'k' : 'gk']],      { expr = true, noremap = true, silent = true  })

-- Set 'CTRL + v' as 'paster'
-- key('', '<C-v>', 'map"_d<Esc>i', remap )
key('v', '<C-v>', 'p', remap )

-- Set 'CTRL + x' as 'cut'
key('v', '<C-x>', 'mad`ai<Right>', {  silent = true  })

-- Set 'CTRL + c' as 'copier'
key('v', '<C-c>', 'may`ai', remap )
key('i', '<C-v>', '<Esc>:Registers<CR>', remap )


-- Create mark.
key('n', "'", '`', remap )

-- Move normaly bottom and up with C+Up and C+Down.
key('i', '<C-Up>',   '<C-o>gk', remap )
key('i', '<C-Down>', '<C-o>gj', remap )
key('n', '<C-Up>',   'gk', remap )
key('n', '<C-Down>', 'gj', remap )


-- Set 'CTRL + z' as 'undo'
key('i', '<C-z>', '<Esc>ui', remap )

-- Set 'CTRL + y' as 'redo'
key('i', '<C-y>', '<Esc><C-r>', remap )

-- Set 'SHIFT + arrows' as 'select' like modern text-editor.
key('n', '<S-Up>', 'v<Up>',            remap )
key('n', '<S-Down>', 'v<Down>',        remap )
key('n', '<S-Left>', 'v<Left>',        remap )
key('n', '<S-Right>', 'v<Right>',      remap )

key('v', '<S-Up>', '<Up>',            remap )
key('v', '<S-Down>', '<Down>',        remap )
key('v', '<S-Left>', '<Left>',        remap )
key('v', '<S-Right>', '<Right>',      remap )

key('i', '<S-Up>', '<Esc>v<Up>',       remap )
key('i', '<S-Down>', '<C-o>v<Down>',   remap )
key('i', '<S-Left>', '<Esc>v<Left>',   remap )
key('i', '<S-Right>', '<C-o>v<Right>', remap )

-- Set 'SHIFT + special-keys' as 'select' like a moden text editor.
key('i', '<S-Home>', '<Esc>v<Home>', remap )
key('i', '<S-End>', '<C-o>v<End><Left>',   remap )

key('n', '<S-Home>', 'v<Home>',      remap )
key('n', '<S-End>', 'v<End><Left>',        remap )
-- key('n', '<S-PageUp>', '<Esc>:call Visual_Scroll_Up()<CR>i<Right><Left>',     remap )
-- key('n', '<S-PageDown>', '<Esc>:call Visual_Scroll_Down()<CR>i<Right><Left>', remap )

-- Set a nice Page-Arrow transition.
-- key('i', '<PageUp>', '<Esc>:call Insert_Scroll_Up()<CR>i',                    remap )
-- key('i', '<PageDown>', '<Esc>:call Insert_Scroll_Down()<CR>i',                remap )
-- key('i', '<S-PageUp>', '<Esc>:call Visual_Scroll_Up()<CR>i<Right><Left>',     remap )
-- key('i', '<S-PageDown>', '<Esc>:call Visual_Scroll_Down()<CR>i<Right><Left>', remap )

-- Indent the current visual selection.
key('v', '<', '<gv', remap )
key('v', '>', '>gv', remap )

-- Set 'Backspace' as 'delete selection' for the visual selection.
key('v', '<BS>', '"_di', remap )

-- Set 'F36 + F35' as 'delete word' in Insert mode, specific for my build of Simple Terminal (suckless) called flarity.
key('i', '<F36><F35>', '<C-w>', remap )
