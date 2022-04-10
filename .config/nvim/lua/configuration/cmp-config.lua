local cmp = require("cmp")

local icons = {
  Text          = "",
  Method        = "",
  Function      = "",
  Constructor   = "",
  Field         = "ﰠ",
  Variable      = "",
  Class         = "ﴯ",
  Interface     = "",
  Module        = "",
  Property      = "ﰠ",
  Unit          = "塞",
  Value         = "",
  Enum          = "",
  Keyword       = "",
  Snippet       = "",
  Color         = "",
  File          = "",
  Reference     = "",
  Folder        = "",
  EnumMember    = "",
  Constant      = "",
  Struct        = "פּ",
  Event         = "",
  Operator      = "",
  TypeParameter = "T",
  Book          = ""
}

-- nvim-cmp setup
cmp.setup {

  snippet = {
   expand = function(args)
    require("luasnip").lsp_expand(args.body)
   end,
  },

 mapping = {
    ["<TAB>"]     = cmp.mapping.select_next_item(),
    ["<C-p>"]     = cmp.mapping.select_prev_item(),
    ["<C-n>"]     = cmp.mapping.select_next_item(),
    ["<C-d>"]     = cmp.mapping.scroll_docs(-4),
    ["<C-f>"]     = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"]     = cmp.mapping.close(),
    ["<CR>"]      = cmp.mapping.confirm {
       behavior = cmp.ConfirmBehavior.Replace,
       select   = true,
    },
    ["<Tab>"] = function(fallback)
       if cmp.visible() then
          cmp.select_next_item()
       elseif require("luasnip").expand_or_jumpable() then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
       else
          fallback()
       end
    end,
    ["<S-Tab>"] = function(fallback)
       if cmp.visible() then
          cmp.select_prev_item()
       elseif require("luasnip").jumpable(-1) then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
       else
          fallback()
       end
    end,
 },

  formatting = {
    format = function(entry, vim_item)
      -- load lspkind icons
      vim_item.kind = string.format(
        "%s %s",
        icons[vim_item.kind],
        vim_item.kind
      )

      vim_item.menu = ({
        nvim_lsp = "力",
        nvim_lua = "",
        luasnip  = icons.Color,
        path     = "﫶",
        buffer   = "﬘",
        look     = icons.Book,
        emoji    = "😎",
      })[entry.source.name]

       return vim_item
   end,
   },

 sources = {
    { name = "nvim_lua", priority = 8 },
    { name = "nvim_lsp", priority = 7 },
    { name = "luasnip", priority = 6 },
    { name = "path", priority = 5 },
    { name = "buffer", priority = 4 },
    { name = "look", priority = 3, keyword_length = 4, option = { convert_case = true, loud = true } },
    { name = "emoji", priority = 2, option = { insert = true } },
    { name = 'calc', priority = 9 }
 },
}
