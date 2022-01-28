-- Plugins start here, source from Packer:
return require('packer').startup(function(use)

  -- Alpha (dashboard) for neovim
  use { 'goolord/alpha-nvim',
    config = require('configuration.screen'),
  }

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  --
  -- LSP
  --

  -- Rooter, go to project working directory automatically
  use 'ahmedkhalf/lsp-rooter.nvim'

  -- LSP auto-complet
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/vim-vsnip'

  -- Zen Mode
  use {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  -- Dim
  use {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
        dimming = {
          alpha = 0.25, -- amount of dimming
          -- we try to get the foreground from the highlight groups or fallback color
          color = { "#fff000", "#ffffff" },
          inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
        },
        context = 10, -- amount of lines we will try to show around the current line
        treesitter = true, -- use treesitter when available for the filetype
        -- treesitter is used to automatically expand the visible text,
        -- but you can further control the types of nodes that should always be fully expanded
        expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
          "function",
          "method",
          "table",
          "if_statement",
        },
        exclude = {}, -- exclude these filetypes
      }
    end
  }

  -- Signs for built-in marks.
  use { 'chentau/marks.nvim',
    config = require'marks'.setup {
      -- whether to map keybinds or not. default true
      default_mappings = true,
      -- which builtin marks to show. default {}
      builtin_marks = { ".", "<", ">", "^" },
      -- whether movements cycle back to the beginning/end of buffer. default true
      cyclic = true,
      -- whether the shada file is updated after modifying uppercase marks. default false
      force_write_shada = false,
      -- how often (in ms) to redraw signs/recompute mark positions. 
      -- higher values will have better performance but may cause visual lag, 
      -- while lower values may cause performance penalties. default 150.
      refresh_interval = 250,
      -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
      -- marks, and bookmarks.
      -- can be either a table with all/none of the keys, or a single number, in which case
      -- the priority applies to all marks.
      -- default 10.
      sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
      -- disables mark tracking for specific filetypes. default {}
      excluded_filetypes = {},
      -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
      -- sign/virttext. Bookmarks can be used to group together positions and quickly move
      -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
      -- default virt_text is "".
      bookmark_0 = {
        sign = "⚑",
        virt_text = "hello world"
      },
      mappings = {}
    }

  }

  -- Signature for LSP
  use { 'ray-x/lsp_signature.nvim',
    config = require('lsp_signature').setup({
      verbose = false, -- show debug line number

      bind = true, -- This is mandatory, otherwise border config won't get registered.
                   -- If you want to hook lspsaga or other signature handler, pls set to false
      doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                     -- set to 0 if you DO NOT want any API comments be shown
                     -- This setting only take effect in insert mode, it does not affect signature help in normal
                     -- mode, 10 by default

      floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

      floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
      -- will set to true when fully tested, set to false will use whichever side has more space
      -- this setting will be helpful if you do not want the PUM and floating win overlap
      fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
      hint_enable = true, -- virtual hint enable
      hint_prefix = "🐼 ",  -- Panda for parameter
      hint_scheme = "String",
      use_lspsaga = false,  -- set to true if you want to use lspsaga popup
      hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
      max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
                       -- to view the hiding contents
      max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
      handler_opts = {
        border = "shadow"   -- double, rounded, single, shadow, none
      },

      always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

      auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
      extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
      zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

      padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

      transparency = 10, -- disabled by default, allow floating win transparent value 1~100
      shadow_blend = 36, -- if you using shadow as border use this set the opacity
      shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
      timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
      toggle_key = nil -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
    })
  }

  --
  -- Menu
  --

  -- Snippets for nvim-cmp
   use {
    "rafamadriz/friendly-snippets",
    event = "InsertEnter",
   }

  -- Completion menu
  use { 'hrsh7th/nvim-cmp',
    config = require('configuration.cmp-config'),
    requires = {
      { "octaltree/cmp-look" },
      --
      { "hrsh7th/cmp-nvim-lsp" },
      --
      { "hrsh7th/cmp-nvim-lua" },
      -- Buffer words.
      { "hrsh7th/cmp-buffer" },
      -- Path autocompletion.
      { "hrsh7th/cmp-path" },
      --
      { "hrsh7th/cmp-cmdline" },
      --
      { "saadparwaiz1/cmp_luasnip" },
      --
      { "hrsh7th/vim-vsnip" },
      --
      { "hrsh7th/cmp-vsnip" },
      --
      { "hrsh7th/vim-vsnip-integ" },
      -- FIXIT: Fork to calculate simple arithmetic expressions and show on the menu.
      { "gabrielbdsantos/cmp-calc" },
      -- Emoji
      { "hrsh7th/cmp-emoji" },
    },
  }

  -- Snippets for lua
  use { "L3MON4D3/LuaSnip",
    config = "luasnip",
  }

   -- Icons on menu
   use 'onsails/lspkind-nvim'

  --
  -- GIT
  --

  -- Show signs of GIT written in lua
  use { 'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    },
    config = require('configuration.git-signs')
  }

  --
  -- Movement
  --

  -- List registers to open.
  use 'tversteeg/registers.nvim'

  -- Restore folds and cursor position
  use 'senderle/restoreview'

  -- Fold code.
  use{ 'anuvyklack/pretty-fold.nvim',
   config = require('configuration.pretty-fold')
  }

  -- Multi line like Sublime Text (My first Text Editor <3)
--  use { 'mg979/vim-visual-multi',
  --}

  -- Start a * or # search from a visual block.


  -- Parse English
  use { 'jose-elias-alvarez/null-ls.nvim',
    config = require('configuration.null-ls')
  }

  -- File manager (nnn)
  use 'mcchrish/nnn.vim'

  -- Smooth scroll with neoscroll
  use { 'karb94/neoscroll.nvim',
    config = require('configuration.neoscroll')
  }

  -- File explorer
  use { 'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = require('configuration.nvim-tree')
  }

  -- Telescope
  use { 'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    config = require('telescope').setup({
      defaults = {
        mappings = {
          i = {
            ['<ESC>'] = require'telescope.actions'.close,
          },
        },
      },
    })
  }

  -- Filetype (to do something when certain files are verified)
  use { 'nathom/filetype.nvim',
    config = require('configuration.ft-start')
  }

  --
  -- Appearance
  --

  -- Scrollbar with LSP
  use { 'petertriho/nvim-scrollbar',
    config = require('configuration.nvim-scrollbar'),
    requires = 'kevinhwang91/nvim-hlslens'
  }

   -- Status information for LSP.
  use { 'j-hui/fidget.nvim',
    config = require('fidget').setup{}
  }

  -- Theme (dark and light)
  use '/home/iris/Git/Projects/arcoiris-nvim-theme'

  -- Special words highlited in comments
  use { "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = require('configuration.todo-comments')
  }

  -- EWW parser for Vim
  use 'elkowar/yuck.vim'

  -- Indent lines without conceal!!!
  -- use { "lukas-reineke/indent-blankline.nvim",
  --   config = require('configuration.indent-blankline')
  -- }

  -- Close buffer without messing up with the window.
  use 'famiu/bufdelete.nvim'

  -- Treesitter (more highlight for syntax_on)
  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }

  -- Move faster between context.
  use { 'andymass/vim-matchup',
     config = require('nvim-treesitter.configs').setup {

      highlight = {
        enable = true,
        disable = {},
      },
      indent = {
        enable = false,
        disable = {},
      },
      autotag = {
        enable = true,
      },
      matchup = {
        enable = true,              -- mandatory, false will disable the whole extension
        --disable = { "c", "ruby" },  -- optional, list of language that will be disabled
      },

    }
  }

  -- Show your functions/classes at the top of the screen.
  -- use 'romgrk/nvim-treesitter-context'

  -- Tabs (galaxyline)
  use { 'glepnir/galaxyline.nvim',
      branch = 'main',
   --    your statusline
      config = require('configuration.galaxyline'),
   --    some optional icons
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  -- Tabs of buffers
  use { 'akinsho/bufferline.nvim',
    config = require('configuration.bufferline'),
    requires = 'kyazdani42/nvim-web-devicons'
  }

  -- Colorizer for strings "#468" Temporary fix for RGBAA
  use { 'kwshi/nvim-colorizer.lua',
   config = require('colorizer').setup(
     { '*' },
     {
       RGB      = true;         -- #RGB hex codes
       RRGGBB   = true;         -- #RRGGBB hex codes
       names    = false;         -- "Name" codes like Green
       RRGGBBAA = true;         -- #RRGGBBAA hex codes
       rgb_fn   = true;         -- CSS rgb() and rgba() functions
       hsl_fn   = true;         -- CSS hsl() and hsla() functions
       css      = false;        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
       css_fn   = false;        -- Enable all CSS *functions*: rgb_fn, hsl_fn
       -- Available modes: foreground, background
       mode     = 'background'; -- Set the display mode.
     }
   )
 }

end)
