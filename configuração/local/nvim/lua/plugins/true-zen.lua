-- True-Zen Mode (Only for Narrow)
return {
  'Pocco81/true-zen.nvim',
  config = {
    modes = { -- configurations per mode
      ataraxis = {
        shade = "dark", -- if `dark` then dim the padding windows, otherwise if it's `light` it'll brighten said windows
        backdrop = 0, -- percentage by which padding windows should be dimmed/brightened. Must be a number between 0 and 1. Set to 0 to keep the same background color
        minimum_writing_area = { -- minimum size of main window
          width = 70,
          height = 44,
        },
        quit_untoggles = true, -- type :q or :qa to quit Ataraxis mode
        padding = { -- padding windows
          left = 52,
          right = 52,
          top = 0,
          bottom = 0,
        },
        callbacks = { -- run functions when opening/closing Ataraxis mode
          open_pos = nil,
          open_pre = function (_)
            vim.cmd('cabbrev <buffer> q let b:quitting = 1 <bar> q')
            vim.cmd('cabbrev <buffer> wq let b:quitting = 1 <bar> wq')
            vim.cmd('highlight! link ZenBg NonText')
          end,
          close_pre = nil,
          close_pos = function()
            if vim.b.quitting == 1 then
              vim.b.quitting = 0
              vim.cmd('q')
            end
          end,
        },
      },
      minimalist = {
        ignored_buf_types = { "nofile" }, -- save current options from any window except ones displaying these kinds of buffers
        options = { -- options to be disabled when entering Minimalist mode
          number = false,
          relativenumber = false,
          showtabline = 0,
          signcolumn = "no",
          statusline = "",
          cmdheight = 1,
          laststatus = 0,
          showcmd = false,
          showmode = false,
          ruler = false,
          numberwidth = 1
        },
        callbacks = { -- run functions when opening/closing Minimalist mode
          open_pre = nil,
          open_pos = nil,
          close_pre = nil,
          close_pos = nil
        },
      },
      narrow = {
        --- change the style of the fold lines. Set it to:
        --- `informative`: to get nice pre-baked folds
        --- `invisible`: hide them
        --- function() end: pass a custom func with your fold lines. See :h foldtext
        folds_style = "informative",
        run_ataraxis = true, -- display narrowed text in a Ataraxis session
        callbacks = { -- run functions when opening/closing Narrow mode
          open_pre = nil,
          open_pos = nil,
          close_pre = nil,
          close_pos = nil
        },
      },
      focus = {
        callbacks = { -- run functions when opening/closing Focus mode
          open_pre = nil,
          open_pos = nil,
          close_pre = nil,
          close_pos = nil
        },
      }
    },
    integrations = {
      --tmux = false, -- hide tmux status bar in (minimalist, ataraxis)
      --kitty = { -- increment font size in Kitty. Note: you must set `allow_remote_control socket-only` and `listen_on unix:/tmp/kitty` in your personal config (ataraxis)
      --  enabled = false,
      --  font = "+3"
      --},
      twilight = true, -- enable twilight (ataraxis)
      lualine = true, -- hide nvim-lualine (ataraxis)
    },
  }
}
