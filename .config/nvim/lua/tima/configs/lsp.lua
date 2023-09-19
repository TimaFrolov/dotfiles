local lsp = require 'lsp-zero'

local mappings = require 'tima.mappings.lsp'

lsp.preset({
  float_border = 'rounded',
  call_servers = 'local',
  configure_diagnostics = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = {
    preserve_mappings = false,
    omit = mappings.omit,
  },
  manage_nvim_cmp = {
    set_sources = 'recommended',
    set_basic_mappings = true,
    set_extra_mappings = false,
    use_luasnip = true,
    set_format = true,
    documentation_window = true,
  },
})

local function on_attach(client, bufnr)
  mappings.on_attach(client, bufnr)
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
lspconfig.asm_lsp.setup({ on_attach = on_attach })

lsp.setup()
