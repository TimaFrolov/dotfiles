local lsp = require 'lsp-zero'

lsp.preset("recommended")

lsp.ensure_installed({ "lua_ls", "rust_analyzer", "volar", "tsserver", "clangd", })

lsp.setup()

-- local 
-- lspconfig['tsserver'].setup { on_attach = on_attach }
-- lspconfig['volar'].setup { on_attach = on_attach }
-- lspconfig['lua_ls'].setup { on_attach = on_attach }
-- lspconfig['rust_analyzer'].setup { on_attach = on_attach }
-- lspconfig['clangd'].setup { on_attach = on_attach }
