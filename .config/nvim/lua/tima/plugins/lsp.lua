return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    keys = require 'tima.mappings.lsp',
    event = { "BufReadPre", "BufNewFile", "TermOpen" },
    cmd = { "Mason", "MasonUpdate" },
    config = function() require 'tima.configs.lsp' end,
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
    },
  },
  {
    'L3MON4D3/LuaSnip',
    config = function() require 'tima.configs.snippets' end,
    build = "make install_jsregexp",
    event = "InsertCharPre",
    dependencies = { 'saadparwaiz1/cmp_luasnip' },
  },
  {
    'williamboman/mason.nvim',
    build = function() pcall(vim.cmd, 'MasonUpdate') end,
    dependencies = { 'williamboman/mason-lspconfig.nvim', 'neovim/nvim-lspconfig' },
  },
  {
    "stevearc/conform.nvim",
    keys = require 'tima.mappings.conform',
    event = { "BufReadPre", "BufNewFile" },
    config = function() require 'tima.configs.conform' end,
  },
  {
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "luvit-meta/library", words = { "vim%.uv" } },
        },
      },
    },
    "Bilal2453/luvit-meta",
  }
}
