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
    event = { "BufReadPre", "BufNewFile" },
    config = function() require 'tima.configs.treesitter' end,
    build = ':TSUpdate',
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
    }
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build =
        'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
      },
    },
    config = function() require 'tima.configs.telescope' end,
    cmd = "Telescope",
    keys = "<leader>s",
  },
  { "catppuccin/nvim",   name = "catppuccin", lazy = false, priority = 1000 },
  {
    "mbbill/undotree",
    event = { "BufReadPre", "BufNewFile" },
    config = function() require 'tima.configs.undotree' end,
  },
  {
    "tpope/vim-fugitive",
    cmd = "Git",
    keys = "<leader>g",
    config = function() require 'tima.configs.fugitive' end,
  },
  {
    'L3MON4D3/LuaSnip',
    config = function() require 'tima.configs.snippets' end,
    build = "make install_jsregexp",
    event = "InsertCharPre",
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
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
    'williamboman/mason.nvim',
    build = function() pcall(vim.cmd, 'MasonUpdate') end,
    dependencies = { 'williamboman/mason-lspconfig.nvim', 'neovim/nvim-lspconfig' },
  },
  {
    "zbirenbaum/copilot-cmp",
    event = { "BufReadPre", "BufNewFile" },
    config = function() require 'tima.configs.copilot' end,
    dependencies = { 'zbirenbaum/copilot.lua' },
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function() require 'tima.configs.conform' end,
  },
  {
    "mfussenegger/nvim-dap",
    keys = "<leader>d",
    config = function() require 'tima.configs.dap' end,
    dependencies = {
      {
        'rcarriga/nvim-dap-ui',
        config = function() require 'dapui'.setup() end,
      },
      {
        'theHamsta/nvim-dap-virtual-text',
        config = function() require 'nvim-dap-virtual-text'.setup() end,
      },
    }
  },
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require 'tima.configs.lualine' end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function() require 'tima.configs.gitsigns' end,
  },
  {
    "lervag/vimtex",
    ft = "tex",
    config = function() require 'tima.configs.vimtex' end,
  },
  {
    'numToStr/Comment.nvim',
    keys = { { "<leader>c", mode = { 'n', 'v' } } },
    config = function() require 'tima.configs.comment' end,
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertCharPre",
    opts = {}
  },
  {
    'kylechui/nvim-surround',
    keys = { 'cs', 'ys', 'ds', { 'S', mode = 'v' }, },
    config = function() require 'nvim-surround'.setup() end,
  },
  {
    'tpope/vim-sleuth',
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    'saecki/crates.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    ft = "toml",
    config = function() require('crates').setup() end,
  },
  {
    'Civitasv/cmake-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = {
      "CMakeBuild",
      "CMakeRun",
      "CMakeSettings",
      "CMakeDebug",
      "CMakeClean",
      "CMakeGenerate",
    },
    event = "FileWritePre",
    cond = function() return vim.fn.filereadable('CMakeLists.txt') == 1 end,
    config = function() require 'tima.configs.cmake-tools' end,
  },
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons'
    },
    cmd = "Octo",
    config = function() require 'octo'.setup() end,
  },
  {
    'https://codeberg.org/esensar/nvim-dev-container',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    lazy = false,
    opts = {},
  },
  {
    'NvChad/nvim-colorizer.lua',
    lazy = false,
    config = function() require 'tima.configs.colorizer' end,
  },
  { 'folke/neodev.nvim', event = { "BufReadPre" }, opts = {} },
  {
    'folke/which-key.nvim',
    event = { "VeryLazy" },
    config = function() require 'tima.configs.which-key' end,
  },
  {
    'laytan/cloak.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function() require 'tima.configs.cloak' end,
  },
  {
    "folke/noice.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify", 'nvim-treesitter/nvim-treesitter' },
    event = { "VeryLazy" },
    config = function() require 'tima.configs.noice' end,
  },
  {
    'rcarriga/nvim-notify',
    config = function() require 'tima.configs.nvim-notify' end,
  },
}

local options = {
  defaults = {
    lazy = true,
  },
}

require("lazy").setup(plugins, options)
