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
    event = "VeryLazy",
    config = function() require 'tima.configs.treesitter' end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "InsertEnter",
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function() require 'tima.configs.telescope' end,
    cmd = "Telescope",
  },
  { "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },
  {
    "nvim-treesitter/playground",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "InsertEnter",
  },
  {
    "mbbill/undotree",
    event = "InsertEnter",
    config = function() require 'tima.configs.undotree' end,
  },
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    config = function() require 'tima.configs.fugitive' end,
  },
  {
    'L3MON4D3/LuaSnip',
    config = function() require 'tima.configs.snippets' end,
    build = "make install_jsregexp",
    event = "InsertEnter",
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    event = "VeryLazy",
    config = function() require 'tima.configs.lsp' end,
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'L3MON4D3/LuaSnip' },
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    config = function() require 'tima.configs.copilot' end,
    dependencies = { 'zbirenbaum/copilot.lua' },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "InsertEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require 'tima.configs.null_ls' end,
  },
  {
    "mfussenegger/nvim-dap",
    event = "InsertEnter",
    config = function() require 'tima.configs.dap' end,
  },
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require 'tima.configs.lualine' end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "InsertEnter",
    config = function() require 'tima.configs.gitsigns' end,
  },
  {
    "lervag/vimtex",
    ft = "tex",
    config = function() require 'tima.configs.vimtex' end,
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "InsertEnter",
    config = function() require 'fidget'.setup() end,
  },
  {
    'numToStr/Comment.nvim',
    event = "InsertEnter",
    config = function() require 'tima.configs.comment' end,
  },
  {
    'rcarriga/nvim-dap-ui',
    event = "VeryLazy",
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function() require 'dapui'.setup() end,
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    event = "InsertEnter",
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function() require 'nvim-dap-virtual-text'.setup() end,
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {}
  },
  {
    'kylechui/nvim-surround',
    event = "InsertEnter",
    config = function() require 'nvim-surround'.setup() end,
  },
  {
    'tpope/vim-sleuth',
    event = "InsertEnter",
  }
}

local options = {
  defaults = {
    lazy = true,
  },
}

require("lazy").setup(plugins, options)
