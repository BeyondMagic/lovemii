-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
  char = "|",
  buftype_exclude = {"terminal"},
  filetype_exclude = {"alpha"}
}
