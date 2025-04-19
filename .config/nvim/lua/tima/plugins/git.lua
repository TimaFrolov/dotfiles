return {
  {
    'tpope/vim-fugitive',
    cmd = 'Git',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    keys = require('tima.mappings.fugitive'),
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    keys = require('tima.mappings.gitsigns'),
    config = function() require('tima.configs.gitsigns') end,
  },
  {
    'kdheepak/lazygit.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = require('tima.mappings.lazygit'),
  }
}
