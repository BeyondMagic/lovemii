-- Plugins start here, source from Packer:
return require('packer').startup(function(use)

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

  -- Signature for LSP
  use { 'ray-x/lsp_signature.nvim',
    config = require "lsp_signature".setup({
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
    config = require('cmp-config'),
  }

  -- Snippets for lua
  use { "L3MON4D3/LuaSnip",
    config = "luasnip",
  }

  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

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
    config = require('git-signs')
  }

  --
  -- Movement
  --

  -- Smooth scroll with neoscroll
  use { 'karb94/neoscroll.nvim',
    config = require 'scrolling'
  }

  -- File explorer
  use { 'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = require('nvim-tree-files')
  }

  -- Telescope
  use { 'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    config = require'telescope'.setup({
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
  use { 'BeyondMagic/filetype.nvim',
    config = require'ft-start'
  }

  --
  -- Appearance
  --

  -- Theme (dark and light)
  use 'BeyondMagic/arcoiris-nvim-theme'

  -- Special words highlited in comments
  use { "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = require 'note-comments'
  }

  -- Indent lines without conceal!!!
  use { "lukas-reineke/indent-blankline.nvim",
    config = require('indent')
  }

  -- Alpha (dashboard) for neovim
  use { 'goolord/alpha-nvim',
    config = require'alpha'.setup(require'screen'.opts)
  }

  -- Treesitter (more highlight for syntax_on)
  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- Tabs (galaxyline)
  use { 'glepnir/galaxyline.nvim',
      branch = 'main',
   --    your statusline
      config = require'statusline',
   --    some optional icons
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  -- Tabs of buffers
  use { 'akinsho/bufferline.nvim',
    config = require('tabsline'),
    requires = 'kyazdani42/nvim-web-devicons'
  }

  -- Colorizer for strings "#468" Temporary fix for RGBAA
  use { 'kwshi/nvim-colorizer.lua',
   config = require 'colorizer'.setup(
     { '*' },
     {
       RGB      = true;         -- #RGB hex codes
       RRGGBB   = true;         -- #RRGGBB hex codes
       names    = true;         -- "Name" codes like Green
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
