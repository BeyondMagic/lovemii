-- Treesitter (more highlight for syntax_on).

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  depedencies = {
		-- Additional parser: https://github.com/nushell/tree-sitter-nu/blob/main/installation/neovim.md.
		{ "nushell/tree-sitter-nu" }
  },
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
