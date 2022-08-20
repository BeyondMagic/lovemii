require('nvim-treesitter.configs').setup {
  highlight = {

    enable = true,
    disable = {},
    injections = {
      python = {
        docstrings: "markdown",
      },
    },

  },
}
