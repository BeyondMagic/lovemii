-- Completion for snippets.
CAPABILITIES = vim.lsp.protocol.make_client_capabilities()
CAPABILITIES = require('cmp_nvim_lsp').default_capabilities(CAPABILITIES)
CAPABILITIES.textDocument.completion.completionItem.snippetSupport = true

-- LSP Lua (build from source without telemetry (use grep to find config)
--    https://github.com/sumneko/lua-language-server
--    cd lua-language-server
-- Then change the path to your 'lua-language-server' build
require('lsp.lua')

-- Latex
require('lsp.latex')

-- C++ and C
require('lsp.c_c++')

-- Rust
require('lsp.rust')

-- JSON
require('lsp.json')

-- Typescript + Javascript
require('lsp.typescript')

-- Bash Language Server
require('lsp.bash')

-- CSS + Less + SCSS
require('lsp.scss')

-- HTML
require('lsp.html')
