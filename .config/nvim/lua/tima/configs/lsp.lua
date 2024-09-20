local lsp = require 'lsp-zero'
local cmp = require 'cmp'

lsp.preset({
  float_border = 'rounded',
  call_servers = 'local',
  configure_diagnostics = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = {
    preserve_mappings = false,
    omit = { 'gr', 'gd', 'go', 'gi' },
  },
  manage_nvim_cmp = {
    set_sources = 'recommended',
    set_basic_mappings = false,
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
lspconfig.clangd.setup({ cmd = { "clangd", "--malloc-trim", "-j", "2" } })
lspconfig.rust_analyzer.setup({})
lspconfig.ts_ls.setup({})
lspconfig.volar.setup({})
lspconfig.cmake.setup({})
lspconfig.pylsp.setup({})
lspconfig.awk_ls.setup({})
lspconfig.spectral.setup({})
lspconfig.ocamllsp.setup({})
lspconfig.asm_lsp.setup({})
lspconfig.gopls.setup({})
lspconfig.coq_lsp.setup({})

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({
    buffer = bufnr,
    exclude = { 'gl', 'K' }
  })
end)

lsp.setup()

cmp.setup({
  sources = {
    { name = "copilot" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "crates" },
    { name = "lazydev", group_index = 0 }
  },
  mapping = require('tima.mappings.cmp'),
})
