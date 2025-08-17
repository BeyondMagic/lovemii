-- To save the current session (may be restored later).
-- autocmd! VimLeavePre * :mks! ~/.config/nvim/session.vim
vim.api.nvim_create_autocmd( 'VimLeavePre', {
  pattern = '*',
  desc = 'Save session on exit',
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

-- Determine the path for the temporary file.
-- Use the $NEOVIM_CD environment variable if set, otherwise fall back to a default.
local cd_file = vim.env.NEOVIM_CD or "/tmp/nvim_cd_path"

-- Create an autocommand that writes the current directory to the file on exit
vim.api.nvim_create_autocmd("VimLeave", {
  pattern = "*",
  desc = "Write current directory to a temp file on exit",
  callback = function()
    -- ensure the directory exists
    if cd_file and cd_file ~= "" then
      -- vim.fn.getcwd() gets the current working directory
      vim.fn.writefile({ vim.fn.getcwd() }, cd_file)
    end
  end,
})
