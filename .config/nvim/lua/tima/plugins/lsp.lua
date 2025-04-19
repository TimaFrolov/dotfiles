return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function() require('tima.configs.lsp') end,
    keys = require('tima.mappings.lsp'),
  },
  {
    'williamboman/mason.nvim',
    cmd = { 'Mason', 'MasonUpdate' },
    build = function() pcall(vim.cmd, 'MasonUpdate') end,
    config = function() require('mason').setup() end,
    dependencies = { 'williamboman/mason-lspconfig.nvim', 'neovim/nvim-lspconfig' },
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    keys = require('tima.mappings.conform'),
    event = { 'BufReadPre', 'BufNewFile' },
    config = function() require('tima.configs.conform') end,
  },
}
