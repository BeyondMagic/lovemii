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
  use { 'ahmedkhalf/project.nvim',
    config = require('configuration.project')
  }

  -- Unusable variables and functions markup.
  use { 'narutoxy/dim.lua',
    --config = require('configuration.dim')
  }

  -- CPP modern syntax.
  use 'bfrg/vim-cpp-modern'

  -- LSP auto-complet
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/vim-vsnip'

  -- Zen Mode
  use {
    "folke/zen-mode.nvim",
    config = require('configuration.zen-mode')
  }

  -- Dim
  use {
    "folke/twilight.nvim",
    config = require('configuration.twilight')
  }

  -- Signs for built-in marks.
  use { 'chentau/marks.nvim',
    config = require('configuration.marks')
  }

  -- Signature for LSP
  --use { 'ray-x/lsp_signature.nvim',
  --  config = require('configuration.lsp_signature')
  --}

  -- Indent align.
  use 'godlygeek/tabular'

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
      -- Signature for functions.
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      --
      { "hrsh7th/vim-vsnip-integ" },
      --  FIXIT: Fork to calculate simple arithmetic expressions and show on the menu.
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

  -- NIM support (syntax, folding).
  use 'baabelfish/nvim-nim'

  -- File-tree manager.
  use { '/home/iris/Git/Forking/neo-tree.nvim/',
    config = require('configuration.neo-tree'),
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim"
    },
  }

  --
  -- GIT
  --

  -- Show signs of GIT written in lua
  use { 'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
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
  --use { 'mg979/vim-visual-multi',
  --}

  -- Start a * or # search from a visual block.

  -- Parse English
  use { 'jose-elias-alvarez/null-ls.nvim',
    config = require('configuration.null-ls')
  }

  -- File manager (nnn)
  --use 'mcchrish/nnn.vim'

  -- Smooth scroll with neoscroll
  use { 'karb94/neoscroll.nvim',
    config = require('configuration.neoscroll')
  }

  -- File explorer
  -- use { 'kyazdani42/nvim-tree.lua',
  --   requires = 'kyazdani42/nvim-web-devicons',
  --   config = require('configuration.nvim-tree')
  -- }

  -- Telescope
  use { 'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'} },
    config = require('configuration.telescope'),
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
  --use { 'j-hui/fidget.nvim',
  --  config = require('fidget').setup{}
  --}

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
     config = require('configuration.vim-matchup')
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

  -- Colorizer for strings.
  use { 'RRethy/vim-hexokinase',
    config = require('configuration.vim-hexokinase'),
    run    = 'cd ~/.local/share/nvim/site/pack/packer/start/vim-hexokinase && make hexokinase'
  }

  -- Theme (dark and light)
  use '/home/iris/Git/Projects/arcoiris-nvim-theme'

end)