require('lspconfig')
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      hint = { enable = true },
    },
  },
})
vim.lsp.enable('lua_ls')
vim.lsp.config('clangd', { cmd = { 'clangd', '--malloc-trim', '-j', '2' } })
vim.lsp.enable('clangd')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('ts_ls')
vim.lsp.enable('volar')
vim.lsp.enable('cmake')
vim.lsp.enable('pylsp')
vim.lsp.enable('awk_ls')
vim.lsp.enable('spectral')
vim.lsp.enable('ocamllsp')
vim.lsp.enable('asm_lsp')
vim.lsp.enable('gopls')
vim.lsp.enable('coq_lsp')
vim.lsp.config('metals', {
  filetypes = { 'scala', 'sbt' },
  root_markers = { 'build.sbt', 'build.sc', 'build.gradle', 'pom.xml', 'build.mill' },
})
vim.lsp.enable('metals')

vim.diagnostic.config({ virtual_lines = true })
