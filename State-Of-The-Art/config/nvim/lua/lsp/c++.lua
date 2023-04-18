local lspconfig  = require('lspconfig')
--local rp         = lspconfig.util.root_pattern("./")

function root_find(filenames)
  return vim.fs.dirname(vim.fs.find(filenames, { upward = true })[1])
end

-- C++ and C language server
lspconfig.ccls.setup({
  init_options = {

    compilationDatabaseDirectory = "build",

    index = {
      threads  = 2,
      onChange = true,
    },

    clang = {
      --excludeArgs = { "-frounding-math", "-Wc++17-extensions"},
      extraArgs = {
        --"-std=c17",
        "-Wall",
        "-Werror",
        "-Wextra",
        "-pedantic",
        "-Wconversion",
        "-Wsign-conversion",
        "-fwrapv",
        "-ftrivial-auto-var-init=zero",
        --"-Werror=return-type",
        --"-Werror=implicit-fallthrough",
        --"-Werror=implicit-int-conversion",
        --"-Werror=narrowing",
        --"-Werror=uninitialized",
        --"-Werror=pointer-to-int-cast"
      }
    },

    cmd                 = { "ccls" },
    filetypes           = { "c", "cpp", "objc", "objcpp", "hpp" , "h" },
    --offset_encoding     = "utf-32",
    single_file_support = true,
    root_dir = root_find("compile_commands.json", ".ccls", ".git"),
  }
})
