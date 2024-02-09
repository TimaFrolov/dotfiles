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

local lspconfig = require 'lspconfig'

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      hint = { enable = true },
    },
  },
})
lspconfig.clangd.setup({ cmd = { "clangd", "--malloc-trim", "-j=2" } })
lspconfig.rust_analyzer.setup({})
lspconfig.tsserver.setup({})
lspconfig.volar.setup({})
lspconfig.cmake.setup({})
lspconfig.pylsp.setup({})
lspconfig.awk_ls.setup({})
lspconfig.spectral.setup({})
lspconfig.ocamllsp.setup({})
lspconfig.asm_lsp.setup({})
lspconfig.gopls.setup({})

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({
    buffer = bufnr,
    exclude = { 'gl', 'K' }
  })
end)

lsp.setup()
