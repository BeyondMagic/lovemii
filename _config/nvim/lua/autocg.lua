-- Comments are respectively for each 'auto'
--   Switch_Theme ; It does what it does.
--   Scroll functions are for the plugin 'neoscrolling'
--   Return to last edit position when opening files (You want this!)
--   Save session to nvim
--   Signals (USR1toto reload theme
vim.api.nvim_exec(
[[

function! Switch_Theme()
  let &bg=(&bg=='light'?'dark':'light')
  colorscheme arcoiris-nvim
endfunction

function! Visual_Scroll_Up()
  exe "normal v\<PageUp>"
endfunction

function! Visual_Scroll_Down()
  exe "normal v\<PageDown>i"
endfunction

function! Insert_Scroll_Up()
  exe "normal \<PageUp>"
endfunction

function! Insert_Scroll_Down()
  exe "normal \<PageDown>"
endfunction

autocmd! BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
autocmd! VimLeave * :mksession! ~/.config/nvim/session.vim
autocmd! Signal SIGUSR1 :call Switch_Theme()

]], false)
