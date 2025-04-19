return {
  {
    'TimaFrolov/noice.nvim',
    keys = require('tima.mappings.noice'),
    dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
    event = { 'VeryLazy' },
    config = function() require('tima.configs.noice') end,
  },
  {
    'rcarriga/nvim-notify',
    config = function() require('tima.configs.nvim-notify') end,
  },
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function() require('tima.configs.lualine') end,
  },
}
