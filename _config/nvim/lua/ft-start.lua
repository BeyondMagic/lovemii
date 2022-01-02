-- In init.lua or filetype.nvim's config file
require('filetype').setup({
  overrides = {

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

    complex = {
      [".*config/xorg/*"] = function()
        vim.bo.filetype = 'xdefaults'
        vim.api.nvim_command('autocmd! BufWritePost <buffer> :lua Restart_XResources()')
      end,
      [".*config/nvim/*"] = function()
        vim.api.nvim_command('cd ~/git/config/_config/nvim/')
      end,
      [".*git/iris/_personal/beyondmagic.space/ts"] = function()
        vim.bo.filetype = 'xdefaults'
      end,
      [".*git/iris/_personal/beyondmagic.space/templates/*"] = function()
        vim.bo.filetype = 'xdefaults'
        print('lol')
      end,
      [".*git/iris/source/*"] = function()
        vim.api.nvim_command('cd ~/git/iris/')
        --vim.api.nvim_command('set colorcolumn=100')
      end,
    },

--    shebang = {
      -- Set the filetype of files with a dash shebang to sh
--      node = 'js',
--    },
  }
})
