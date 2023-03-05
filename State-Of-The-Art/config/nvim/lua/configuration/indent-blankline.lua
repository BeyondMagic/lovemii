vim.opt.listchars:append("space:⋅")
--vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
  --char                 = "|",
  buftype_exclude      = { "terminal" },
  filetype_exclude     = { "alpha" },
  show_end_of_line     = true,
  space_char_blankline = " ",

  show_trailing_blankline_indent = false,
}
