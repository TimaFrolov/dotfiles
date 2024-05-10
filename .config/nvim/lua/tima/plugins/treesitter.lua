return {
  "nvim-treesitter/nvim-treesitter",
  keys = require('tima.mappings.treesitter').lazy,
  event = { "BufReadPre", "BufNewFile" },
  config = function() require 'tima.configs.treesitter' end,
  build = ':TSUpdate',
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-textobjects",
  }
}
