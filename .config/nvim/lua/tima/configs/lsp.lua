local lsp = require 'lsp-zero'
local telescope = require("telescope.builtin")

lsp.preset("recommended")

local function on_attach(_, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    -- TODO: find a way to move it to mappings.lua, or make better file structure
    vim.keymap.set('n', 'gr', telescope.lsp_references, { buffer = true })
end

local lspconfig = require 'lspconfig'

lspconfig.lua_ls.setup({ on_attach = on_attach })
lspconfig.clangd.setup({ on_attach = on_attach })
lspconfig.rust_analyzer.setup({ on_attach = on_attach })
lspconfig.tsserver.setup({ on_attach = on_attach })
lspconfig.clangd.setup({ on_attach = on_attach })
lspconfig.volar.setup({ on_attach = on_attach })
lspconfig.cmake.setup({ on_attach = on_attach })
lspconfig.pylsp.setup({ on_attach = on_attach })
lspconfig.awk_ls.setup({ on_attach = on_attach })
lspconfig.spectral.setup({ on_attach = on_attach })
lspconfig.ocamllsp.setup({ on_attach = on_attach })

lsp.setup()
