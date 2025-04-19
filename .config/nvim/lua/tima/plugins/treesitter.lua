return {
  {
    'nvim-treesitter/nvim-treesitter',
    keys = require('tima.mappings.treesitter').lazy,
    event = { 'BufReadPre', 'BufNewFile' },
    build = ':TSUpdate',
    config = function() require('tima.configs.treesitter') end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
  },
}
