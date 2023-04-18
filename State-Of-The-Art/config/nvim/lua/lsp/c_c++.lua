--local lspconfig  = require('lspconfig')
----local rp         = lspconfig.util.root_pattern("./")
--
--local root_find = function (filenames)
--  return vim.fs.dirname(vim.fs.find(filenames, { upward = true })[1])
--end

local util = require "lspconfig.util"
local server_config = {
    filetypes = { "c", "cpp", "objc", "objcpp", "opencl" },
    root_dir = function(fname)
        return util.root_pattern("compile_commands.json", "compile_flags.txt", ".git")(fname)
            or util.find_git_ancestor(fname)
    end,
    init_options = {
      cache = {
        directory = vim.fs.normalize "~/.cache/ccls/" -- if on nvim 0.8 or higher
      }
    },
    on_attach = function(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
      end
    end,
    capabilities = CAPABILITIES
}

require("ccls").setup { lsp = { lspconfig = server_config } }


-- C++ and C language server
--lspconfig.ccls.setup({
--  init_options = {
--
--    compilationDatabaseDirectory = "build",
--
--    index = {
--      threads  = 2,
--      onChange = true,
--    },
--
--    clang = {
--      --excludeArgs = { "-frounding-math", "-Wc++17-extensions"},
--      extraArgs = {
--        --"-std=c17",
--        "-Wall",
--        "-Werror",
--        "-Wextra",
--        "-pedantic",
--        "-Wconversion",
--        "-Wsign-conversion",
--        "-fwrapv",
--        "-ftrivial-auto-var-init=zero",
--        --"-Werror=return-type",
--        --"-Werror=implicit-fallthrough",
--        --"-Werror=implicit-int-conversion",
--        --"-Werror=narrowing",
--        --"-Werror=uninitialized",
--        --"-Werror=pointer-to-int-cast"
--      }
--    },
--
--    cmd                 = { "ccls" },
--    filetypes           = { "c", "cpp", "objc", "objcpp", "hpp" , "h" },
--    --offset_encoding     = "utf-32",
--    single_file_support = true,
--    root_dir = root_find({
--      "compile_commands.json",
--      ".ccls",
--      ".git"
--    }),
--  }
--})
