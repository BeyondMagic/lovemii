-- Comments are respectively for each 'auto'
--   Switch_Theme ; It does what it does.
--   Scroll functions are for the plugin 'neoscrolling'
--   Return to last edit position when opening files (You want this!)
--   Save session to nvim
--   Signals (USR1toto reload theme
vim.api.nvim_command(
[[

" For some reason ?? this do not work with neovim lua builtin comands.
"nmap <C-Down> z%
"nmap <C-Up> g%
"imap <C-Down> <Esc>z%i
"imap <C-Up> <Esc>g%i
"
"function! DisableST()
"  return " "
"endfunction
"au BufEnter NvimTree setlocal statusline=%!DisableST()

]])

-- To save the current session (may be restored later).
-- autocmd! VimLeavePre * :mks! ~/.config/nvim/session.vim
vim.api.nvim_create_autocmd( 'VimLeavePre', {
  pattern = '*',
  command = ":mks! ~/.config/nvim/session.vim"
})


-- To switch themes.
vim.api.nvim_create_autocmd( 'Signal', {
  pattern = 'SIGUSR1',
  callback = function ()
    vim.cmd( [[let &bg=(&bg=='light'?'dark':'light' ]] )
    vim.cmd( [[colorscheme arcoiris-nvim]] )
  end,
})
