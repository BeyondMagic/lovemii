-- In init.lua or filetype.nvim's config file
vim.filetype.add({
    extension = {
        h = function()
            -- Use a lazy heuristic that #including a C++ header means it's a
            -- C++ header
            if vim.fn.search("\\C^#include <[^>.]\\+>$", "nw") == 1 then
                return "cpp"
            end
            return "c"
        end,
        md = function()
          vim.api.nvim_command('setlocal spell!')
        end,
        csv = "csv",
        cl  = "opencl",
        env = "env",

    },
    pattern = {
      -- Go to root configuration.
      [".*config/nvim/.*"] = function()
        vim.api.nvim_command('cd ~/Git/Personal/magic/.config/nvim/')
      end,
      [".*config/wired/.*"] = function()
        vim.api.nvim_command('cd ~/Git/Personal/magic/.config/wired/')
        return 'rust'
      end,
      [".*Projects/flarity/.*"] = function()
        vim.api.nvim_command('cd ~/Git/Projects/flarity/')
      end,
      [".*config/eww/.*"] = function()
        vim.api.nvim_command('cd ~/Git/Personal/magic/.config/eww/')
      end,
      [".*config/picom/.*"] = function()
        vim.api.nvim_command('cd ~/Git/Personal/magic/.config/picom/')
      end,
      [".*config/xorg/.*"] = function()
        vim.api.nvim_command('cd ~/.config/xorg/')
        vim.api.nvim_command('autocmd! BufWritePost <buffer> :lua Restart_XResources()')
        return 'xdefaults'
      end,

      -- BeyondMagic.space
      [".*Personal/beyondmagic.space/ts/.*"] = function()
        vim.api.nvim_command('cd ~/Git/Personal/beyondmagic.space/')
        vim.api.nvim_command("autocmd! BufWritePost <buffer> :call jobstart('./make.sh --ts')")
        return 'typescript'
      end,
      [".*Personal/beyondmagic.space/templates/.*"] = function()
        vim.api.nvim_command('cd ~/Git/Personal/beyondmagic.space/')
        vim.api.nvim_command("autocmd! BufWritePost <buffer> :call jobstart('./make.sh --templates')")
        return 'html'
      end,
      [".*Personal/beyondmagic.space/sass/.*"] = function()
        vim.api.nvim_command('cd ~/Git/Personal/beyondmagic.space/')
        vim.api.nvim_command("autocmd! BufWritePost <buffer> :call jobstart('./make.sh --silent-sass')")
        return 'sass'
      end,
      [".*Personal/beyondmagic.space/data/.*"] = function()
        vim.api.nvim_command('cd ~/Git/Personal/beyondmagic.space/')
        vim.api.nvim_command("autocmd! BufWritePost <buffer> :call jobstart('./make.sh --data')")
        return 'json5'
      end,
      [".*Story/Script/.*"] = function()
        vim.api.nvim_command('cd ~/Story/Script/')
        vim.api.nvim_command('set colorcolumn=85')
        vim.api.nvim_command('set textwidth=84')
        vim.api.nvim_set_keymap('i', '<Up>', '<Up>',     { noremap = true, silent = true  })
        vim.api.nvim_set_keymap('i', '<Down>', '<Down>', { noremap = true, silent = true  })
        return 'txt'
      end,
    },
    filename = {
      ['dunstrc.template'] = function()
        vim.api.nvim_command('cd ~/.config/dunst/')
        vim.api.nvim_command('autocmd! BufWritePost <buffer> :lua Restart_Dunst()')
        return 'sh'
      end,
      ['zathurarc.template'] = function()
        vim.api.nvim_command('cd ~/.config/zathura/')
        vim.api.nvim_command('autocmd! BufWritePost <buffer> :lua Restart_Zathura()')
        return 'python'
      end,
      xbindkeysrc = function()
        vim.api.nvim_command('cd ~/.config/xbindkeys/')
        vim.api.nvim_command('autocmd! BufWritePost <buffer> :lua Restart_XBindKeys()')
      end,
      aliasesrc = function()
        vim.api.nvim_command('cd ~/.config/zsh/')
        return 'sh'
      end
	  },
})
