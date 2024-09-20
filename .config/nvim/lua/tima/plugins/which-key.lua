return {
  'folke/which-key.nvim',
  event = { "VeryLazy" },
  dependencies = { 'echasnovski/mini.icons' },
  config = function() require 'tima.configs.which-key' end,
}
