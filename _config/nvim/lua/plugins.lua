-- Plugins start here, source from Packer, recommend more 'lua' plugins:
return require('packer').startup(function(use)

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Rooter, go to project working directory automatically
  use 'ahmedkhalf/lsp-rooter.nvim'

  -- File explorer
  use { 'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = require('nvim-tree-files')
  }

  -- Show signs of GIT written in lua
  use { 'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = require('git-signs')
  }

  -- Indent lines without conceal!!!
  use { "lukas-reineke/indent-blankline.nvim",
    config = require('indent')
  }

  -- Alpha (dashboard) for neovim
  use { 'goolord/alpha-nvim',
    config = function ()
        require'alpha'.setup(require'screen'.opts)
    end
  }

  -- LSP auto-complet
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'hrsh7th/vim-vsnip'

  -- Treesitter (more highlight for syntax_on)
  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- Tabs (galaxyline)
  use { 'glepnir/galaxyline.nvim',
      branch = 'main',
   --    your statusline
      config = function() require'statusline' end,
   --    some optional icons
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  -- Colorizer for strings "#468"
  use { 'kwshi/nvim-colorizer.lua',
   config = function() require 'colorizer'.setup() end
 }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  -- Tabs of buffers
  use {'akinsho/bufferline.nvim',
    config = require('tabsline'),
    requires = 'kyazdani42/nvim-web-devicons'
  }

  -- Theme (dark and light)
  use 'BeyondMagic/arcoiris-nvim-theme'

end)
