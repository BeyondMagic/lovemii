-- In init.lua or filetype.nvim's config file
require('filetype').setup({
  overrides = {
    --    extensions = {
    -- Set the filetype of *.pn files to potion
    -- md = 'markdown'
    --    },
    --    literal = {
    -- Set the filetype of files named "MyBackupFile" to lua
    -- MyBackupFile = 'lua',
    --    },
    --    complex = {
    -- Set the filetype of any of XResource themes
    -- Set the filetype of any full filename matching the regex to gitconfig
    -- [".*git/config"] = "gitconfig",  -- Included in the plugin
    --    },

    -- The same as the ones above except the keys map to functions
    function_extensions = {
      conf = function()
        vim.bo.filetype = 'gitconfig'
      end,
      md = function()
        vim.api.nvim_command('setlocal spell!')
        vim.bo.filetype = 'markdown'
      end,
    },

    function_literal = {
      ["dunstrc.template"] = function()
        vim.bo.filetype = 'gtkrc'
        vim.api.nvim_command('autocmd! BufWritePost <buffer> :lua Restart_Dunst()')
      end,
      ["zathurarc.template"] = function()
        vim.bo.filetype = 'python'
        vim.api.nvim_command('autocmd! BufWritePost <buffer> :lua Restart_Zathura()')
      end,
      xbindkeysrc = function()
        vim.bo.filetype = 'zsh'
        vim.api.nvim_command('autocmd! BufWritePost <buffer> :lua Restart_XBindKeys()')
      end
    },

    function_complex = {
      [".*config/xorg/*"] = function()
        vim.bo.filetype = 'xdefaults'
        vim.api.nvim_command('autocmd! BufWritePost <buffer> :lua Restart_XResources()')
      end,
    },
  }
})
