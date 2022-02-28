require('nvim-treesitter.configs').setup {

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
