local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    config = function() require 'tima.configs.treesitter' end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = false,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function() require 'tima.configs.telescope' end,
    cmd = "Telescope",
  },
  { "catppuccin/nvim",            name = "catppuccin", lazy = false, priority = 1000 },
  { "nvim-treesitter/playground", lazy = false },
  { "mbbill/undotree",            lazy = false },
  { "tpope/vim-fugitive",         lazy = false },
  {
    'L3MON4D3/LuaSnip',
    config = function() require 'tima.configs.snippets' end,
    build = "make install_jsregexp"
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    lazy = false,
    config = function() require 'tima.configs.lsp' end,
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {                            -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' },     -- Required
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    lazy = false,
    config = function() require 'tima.configs.copilot' end,
    dependencies = { 'zbirenbaum/copilot.lua' },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require 'tima.configs.null_ls' end,
  },
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    config = function() require 'tima.configs.dap' end,
  },
  {
    "lervag/vimtex",
    ft = "tex",
    config = function() require 'tima.configs.vimtex' end,
  },
}

local options = {
  defaults = {
    lazy = true,
  },
}

require("lazy").setup(plugins, options)
