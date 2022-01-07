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

  -- Signature for LSP
  use { 'ray-x/lsp_signature.nvim',
    config = require('lsp_signature').setup({
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      handler_opts = {
        border = "single" -- double, rounded, single, shadow, none
      }
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
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-cmdline" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/vim-vsnip" },
      { "hrsh7th/cmp-vsnip" },
      { "hrsh7th/vim-vsnip-integ" },
      { "f3fora/cmp-spell", { "hrsh7th/cmp-calc" }, { "hrsh7th/cmp-emoji" } },
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
      'nvim-lua/plenary.nvim'
    },
    config = require('configuration.git-signs')
  }

  --
  -- Movement
  --

  -- Restore folds and cursor position
  use 'senderle/restoreview'

  -- Fold code.
  use{ 'anuvyklack/pretty-fold.nvim',
   config = require('configuration.pretty-fold')
  }

  -- Multi line like Sublime Text (My first Text Editor <3)
--  use { 'mg979/vim-visual-multi',
  --}

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

  -- Theme (dark and light)
  use 'BeyondMagic/arcoiris-nvim-theme'
  use "rebelot/kanagawa.nvim"

  -- Special words highlited in comments
  use { "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = require('configuration.todo-comments')
  }

  -- Indent lines without conceal!!!
  use { "lukas-reineke/indent-blankline.nvim",
    config = require('configuration.indent-blankline')
  }

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
