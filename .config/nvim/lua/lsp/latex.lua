require('lspconfig').texlab.setup({

  cmd                 = { "texlab" },
  filetypes           = { "tex", "bib" },
  single_file_support = true,
  --root_dir = '',
  settings = {
    texlab = {
      auxDirectory    = ".",
      bibtexFormatter = "texlab",
      build = {
        args = { "-pdf",
                 "%f" },
        executable         = "latexmk",
        forwardSearchAfter = false,
        onSave             = true
      },
      chktex = {
        onEdit        = false,
        onOpenAndSave = false
      },
      diagnosticsDelay    = 300,
      formatterLineLength = 80,
      forwardSearch = {
        args = {}
      },
      latexFormatter = "latexindent",
      latexindent = {
        modifyLineBreaks = false
      }
    }
  },

})
