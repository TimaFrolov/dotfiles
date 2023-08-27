local lsp = require 'lsp-zero'

lsp.preset("recommended")

local lspconfig = require 'lspconfig'

lspconfig.lua_ls.setup({})
lspconfig.clangd.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.tsserver.setup({
  on_attach = function(client, _)
    client.resolved_capabilities.document_formatting = false
  end,
})
lspconfig.clangd.setup({})
lspconfig.volar.setup({
  on_attach = function(client, _)
    client.resolved_capabilities.document_formatting = false
  end,
})
lspconfig.cmake.setup({})
lspconfig.pylsp.setup({})
lspconfig.awk_ls.setup({})
lspconfig.spectral.setup({})
lspconfig.ocamllsp.setup({})

lsp.setup()
