-- Treesitter (more highlight for syntax_on).

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function ()

    require('nvim-treesitter.configs').setup {
      highlight = {
        enable = true,
        disable = {},
        --injections = {
        --  python = {
        --    docstrings: "markdown",
        --  },
        --}
      },
    }

  end
}
