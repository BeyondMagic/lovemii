require('lspconfig').rls.setup({
  settings = {
    rust = {
      unstable_features = true,
      build_on_save     = false,
      all_features      = true,
    },
  },
  capabilities = CAPABILITIES,
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, bufnr)
    end
  end,
})
