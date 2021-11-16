-- Comments are respectively for each 'auto'
--   Return to last edit position when opening files (You want this!)
--   Set spell check in markdown files
--   When save xbindkeys, reset
--   When save dunst, notify
--   Save session to nvim
--   Signals (USR1toto reload theme
vim.api.nvim_exec(
[[

function! Switch_Theme()
  let &bg=(&bg=='light'?'dark':'light')
  colorscheme arcoiris-nvim
endfunction

function! Restart_Dunst()
  !eval "killall dunst"
  !eval "dunst -s -follow keyboard &"
  !notify-send.sh -i /usr/share/icons/Adwaita/16x16/actions/folder-new-symbolic.symbolic.png 'Testing Dunst'"
endfunction

function! Restart_XBindKeys()
  !eval "killall xbindkeys"
  !eval "xbindkeys -f /home/iris/Base/xbindkeysrc"
endfunction

function! Restart_XResources()
  !eval "xrdb ~/.config/xorg/XResources"
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
autocmd! FileType markdown :setlocal spell!
autocmd! BufRead,BufNewFile COMMIT_EDITMSG setlocal spell!
autocmd! BufRead,BufNewFile $HOME/.config/xorg/** :setf xdefaults
autocmd! BufWritePost $HOME/.config/xorg/** :call Restart_XResources()
autocmd! BufWritePost $HOME/Base/xbindkeysrc :call Restart_XBindKeys()
autocmd! BufWritePost $HOME/.config/dunst/dunstrc_t :call Restart_Dunst()
autocmd! VimLeave * :mksession! ~/.config/nvim/session.vim
autocmd! Signal SIGUSR1 :call Switch_Theme()

]], false)
