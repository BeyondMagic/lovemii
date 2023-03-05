-- To save the current session (may be restored later).
-- autocmd! VimLeavePre * :mks! ~/.config/nvim/session.vim
vim.api.nvim_create_autocmd( 'VimLeavePre', {
  pattern = '*',
  command = ":mks! ~/.config/nvim/session.vim"
})


-- To switch themes.
-- vim.api.nvim_create_autocmd( 'Signal', {
--   pattern = 'SIGUSR1',
--   callback = function ()
--     vim.cmd( [[let &bg=(&bg=='light'?'dark':'light' ]] )
--     vim.cmd( [[colorscheme arcoiris-nvim]] )
--   end,
-- })

