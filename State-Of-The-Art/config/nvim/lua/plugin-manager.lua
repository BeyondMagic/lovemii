-- To install lazy.nvim automatically.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

--require('lazy').setup({
--  -- Theme (dark and light)
--  {
--    dir      = '~/Programming/Projects/arcoiris-nvim-theme',
--    name     = 'arcoiris',
--    dev      = true,
--    lazy     = false, -- make sure we load this during startup if it is your main colorscheme
--    priority = 1000,  -- make sure to load this before all the other start plugins
--    config   = function ()
--      vim.cmd.colorscheme('arcoiris')
--      -- Setting our theme set
--      -- 1. 'light' for white theme.
--      -- 2. 'dark' for dark theme.
--      vim.api.nvim_set_option('background', 'dark')
--
--      -- Load main theme.
--      require('theme')
--    end
--  }
--})

-- Plugins start here, source from Packer:
require('lazy').setup('plugins')
