-- To be used anywhere.
local function job (command)

  vim.api.nvim_command( "call jobstart('" .. command .."')" )

end

-- https://github.com/BeyondMagic/whitedove
-- Personal website.
local function build (type)

  vim.api.nvim_create_autocmd( 'BufWritePost', {
    pattern = '<buffer>',
    callback = function ()
      job( './build.sh ' .. type )
    end,
  })

end

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

        -- Spelling fix.
        md = function()
          vim.api.nvim_command('setlocal spell!')
        end,

        --
        csv = "csv",
        cl  = "opencl",
        env = "env",
        rasi = "rasi",

        -- Latex
        tex = function()
          vim.api.nvim_create_autocmd( 'BufWritePost', {
            pattern = '<buffer>',
            callback = function ()
              local cache_folder = '/home/iris/.cache/latex'
              local all_letters  = '[%w%sA-Za-zÀ-ÖØ-öø-ÿ'
              local buffer_name  = vim.api.nvim_buf_get_name(0)

              local name_file    = string.gsub(buffer_name, all_letters .. ".]+/", '')
                    name_file    = string.gsub(name_file, '.' .. all_letters .. "]+$", '')

              local pdf_file     = cache_folder .. name_file .. '.pdf'

              local directory    = string.gsub(buffer_name, all_letters .. '.]+$', '')

              job( 'latexmk -pdf -output-directory=' .. cache_folder ..
                ' -interaction=nonstopmode -synctex=1 "' .. buffer_name .. '"')
              job('sleep 0.3s; cp -f' .. ' "' .. pdf_file .. '" "' .. directory .. '"')
            end,
          })
        end,

    },
    pattern = {

      -- Go to root configuration of some projects.
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

        -- Make up the XORG.
        vim.api.nvim_create_autocmd( 'BufWritePost', {
          pattern = '<buffer>',
          callback = function ()
            os.execute( "xrdb ~/.config/xorg/XResources" )
          end,
        })

        return 'xdefaults'
      end,

      -- beyondMagic.space
      -- Personal website.
      [".*Personal/beyondmagic.space/source/typescript/global.ts"] = function()
        vim.api.nvim_command('cd ~/Git/Personal/beyondmagic.space/')
        build('ts global')
      end,
      [".*Personal/beyondmagic.space/source/typescript/main.ts"] = function()
        vim.api.nvim_command('cd ~/Git/Personal/beyondmagic.space/')
        build('ts main')
      end,
      [".*Personal/beyondmagic.space/source/typescript/modules/.*ts"] = function()
        vim.api.nvim_command('cd ~/Git/Personal/beyondmagic.space/')
        build('ts main')
      end,
      [".*Personal/beyondmagic.space/source/html/.*html"] = function()
        vim.api.nvim_command('cd ~/Git/Personal/beyondmagic.space/')
        build('html')
      end,
      [".*Personal/beyondmagic.space/source/scss/.*"] = function()
        vim.api.nvim_command('cd ~/Git/Personal/beyondmagic.space/')
        build('scss')
      end,

      -- NWrite - WhiteDove
      -- https://github.com/BeyondMagic/whitedove
      [".*Projects/WhiteDove/whitedove/source/html/.*"] = function()
        vim.api.nvim_command('cd ~/Git/Projects/WhiteDove/whitedove/')
        build('html')
      end,
      [".*Projects/WhiteDove/whitedove/source/scss/.*"] = function()
        vim.api.nvim_command('cd ~/Git/Projects/WhiteDove/whitedove/')
        build('scss')
      end,
      [".*Projects/WhiteDove/whitedove/source/ts/.*"] = function()
        vim.api.nvim_command('cd ~/Git/Projects/WhiteDove/whitedove/')
        build('ts main')
      end,
      [".*Projects/WhiteDove/whitedove/source/ts/global.ts"] = function()
        vim.api.nvim_command('cd ~/Git/Projects/WhiteDove/whitedove/')
        build('ts global')
      end,

      -- Story :)
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

      -- For Typescript projects.
      ['tsconfig.json'] = 'json5',

      -- Those template files work with the system to auto-update certain configuration of programs.
      ['zathurarc.template'] = function()
        vim.api.nvim_command('cd ~/.config/zathura/')

        -- Make up the zathurarc.
        vim.api.nvim_create_autocmd( 'BufWritePost', {
          pattern = '<buffer>',
          callback = function ()
            os.execute( [[zsh -c ". ~/.config/zsh/aliasesrc; up_zathura"]] )
          end,
        })

        return 'python'
      end,

      -- To work within the folder plus LSP.
      aliasesrc = function()
        vim.api.nvim_command('cd ~/.config/zsh/')
        return 'sh'
      end,

      -- https://github.com/kovetskiy/sxhkd-vim
      sxhkdrc = function()
      vim.api.nvim_create_autocmd( 'BufWritePost', {
        pattern = '<buffer>',
        callback = function ()
          job('pkill -USR1 -x sxhkd')
        end,
      })

        return 'sxhkd'
      end,
	  },
})
