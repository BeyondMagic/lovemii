-- vim.filetype.add({
--   extension = {
--     h = function()
--         -- Use a lazy heuristic that #including a C++ header means it's a
--         -- C++ header
--         if vim.fn.search("\\C^#include <[^>.]\\+>$", "nw") == 1 then
--             return "cpp"
--         end
--         return "c"
--     end,
--     csv = "csv",
--     cl = "opencl",
--     env = "env",
--   },
-- })

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
        vim.bo.filetype = 'lua'
        vim.api.nvim_command('cd ~/git/config/_config/nvim/')
--        vim.api.nvim_command('autocmd! BufWritePost <buffer> :luafile %')
      end,

      [".*_personal/beyondmagic.space/ts/*"] = function()
        vim.bo.filetype = 'typescript'
        vim.api.nvim_command('cd ~/git/_personal/beyondmagic.space/')
        vim.api.nvim_command("autocmd! BufWritePost <buffer> :call jobstart('./make.sh --ts')")
      end,
      [".*_personal/beyondmagic.space/templates/*"] = function()
        vim.bo.filetype = 'html'
        vim.api.nvim_command('cd ~/git/_personal/beyondmagic.space/')
        vim.api.nvim_command("autocmd! BufWritePost <buffer> :call jobstart('./make.sh --templates')")
      end,
      [".*_personal/beyondmagic.space/sass/*"] = function()
        vim.bo.filetype = 'sass'
        vim.api.nvim_command('cd ~/git/_personal/beyondmagic.space/')
        vim.api.nvim_command("autocmd! BufWritePost <buffer> :call jobstart('./make.sh --silent-sass')")
      end,
      [".*_personal/beyondmagic.space/data/*"] = function()
        vim.bo.filetype = 'json5'
        vim.api.nvim_command('cd ~/git/_personal/beyondmagic.space/')
        vim.api.nvim_command("autocmd! BufWritePost <buffer> :call jobstart('./make.sh --data')")
      end,

      [".*git/iris/source/*"] = function()
        vim.bo.filetype = 'cpp'
        vim.api.nvim_command('cd ~/git/iris/')
        -- vim.api.nvim_command('set colorcolumn=100')
      end,
    },

--    shebang = {
      -- Set the filetype of files with a dash shebang to sh
--      node = 'js',
--    },
  }
})
