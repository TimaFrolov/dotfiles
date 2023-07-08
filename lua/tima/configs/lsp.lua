local lsp = require 'lsp-zero'

lsp.preset("recommended")

local lspconfig = require 'lspconfig'

lspconfig.lua_ls.setup({})
lspconfig.clangd.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.tsserver.setup({})
lspconfig.clangd.setup({})

lsp.setup()

-- local 
-- lspconfig['tsserver'].setup { on_attach = on_attach }
-- lspconfig['volar'].setup { on_attach = on_attach }
-- lspconfig['lua_ls'].setup { on_attach = on_attach }
-- lspconfig['rust_analyzer'].setup { on_attach = on_attach }
-- lspconfig['clangd'].setup { on_attach = on_attach }
