return {
  {
    "tpope/vim-fugitive",
    cmd = "Git",
    keys = require 'tima.mappings.fugitive',
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = require 'tima.mappings.gitsigns',
    config = function() require 'tima.configs.gitsigns' end,
  },
}
