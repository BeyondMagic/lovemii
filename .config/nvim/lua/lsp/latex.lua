require('lspconfig').texlab.setup({

  cmd                 = { "texlab" },
  filetypes           = { "tex", "bib" },
  single_file_support = true,
  --root_dir = '',
  settings = {
    texlab = {
      auxDirectory    = '.',
      bibtexFormatter = "texlab",
      build = {
        args  =
          { "-pdf",
            --"-output-directory=" .. cache_latex,
            "-interaction=nonstopmode",
            "-synctex=1",
            "%f" },
        executable         = "latexmk",
        forwardSearchAfter = false,
        onSave             = false
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
      -- TODO: Using as a way to actually pass PDF files.
      latexFormatter = "latexindent",
      latexindent = {
        modifyLineBreaks = false
      }
    }
  },

})
