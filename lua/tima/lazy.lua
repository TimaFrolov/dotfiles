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
  "nvim-treesitter/nvim-treesitter",
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
    lazy = false,
    cmd = "Telescope",
  },
  { "catppuccin/nvim",    name = "catppuccin", lazy = false, priority = 1000 },
  "nvim-treesitter/playground",
  { "mbbill/undotree",    lazy = false },
  { "tpope/vim-fugitive", lazy = false },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    lazy = false,
    config = function () require 'tima.configs.lsp' end,
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {                        -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' }, -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' }, -- Required
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    lazy = false,
    config = function () require 'tima.configs.copilot' end,
    dependencies = { 'zbirenbaum/copilot.lua' },
  },
  {
    "lervag/vimtex",
    ft="tex",
    config=function () require 'tima.configs.vimtex' end,
  },
}

local options = {
  defaults = {
    lazy = true,
  },
}

require("lazy").setup(plugins, options)
