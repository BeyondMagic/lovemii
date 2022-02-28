local lspconfig = require('lspconfig')
local rp = lspconfig.util.root_pattern("./")

-- C++ and C language server
lspconfig.ccls.setup {
  init_options = {

    compilationDatabaseDirectory = "build",

    index = {
      threads  = 0,
      onChange = true,
    },

    cache = {
      directory = "/home/iris/.cache/ccls/"
    },

    clang = {
      excludeArgs = { "-frounding-math"},
      extraArgs   = {
        "-Werror=return-type",
        "-Werror=implicit-fallthrough",
        "-Werror=implicit-int-conversion",
        "-Werror=narrowing",
        "-Werror=uninitialized",
        "-Werror=pointer-to-int-cast"
      }
    },

    cmd                 = { "ccls" },
    filetypes           = { "c", "cpp", "objc", "objcpp", "hpp" },
    --offset_encoding     = "utf-32",
    single_file_support = true,
    root_dir = rp("compile_commands.json", ".ccls", ".git"),
  }
}


