-- Comments are respectively for each 'auto'
--   Return to last edit position when opening files (You want this!)
--   Set spell check in markdown files
--   When save xbindkeys, reset
--   When save dunst, notify
--   Save session to nvim
--   Signals (USR1toto reload theme
vim.api.nvim_exec(
[[

autocmd! BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
autocmd! FileType markdown setlocal spell!
autocmd! BufRead,BufNewFile COMMIT_EDITMSG setlocal spell!
autocmd! BufWritePost $HOME/Base/xbindkeysrc !eval "killall xbindkeys; xbindkeys -f /home/iris/Base/xbindkeysrc"
autocmd! BufWritePost $HOME/.config/dunst/dunstrc !eval "killall dunst; dunst & notify-send -i /usr/share/icons/Adwaita/16x16/actions/folder-new-symbolic.symbolic.png 'Testing Dunst'"
autocmd! VimLeave * :mksession! ~/.config/nvim/session.vim
autocmd! Signal SIGUSR1 let &bg=(&bg=='light'?'dark':'light')

]], false)
