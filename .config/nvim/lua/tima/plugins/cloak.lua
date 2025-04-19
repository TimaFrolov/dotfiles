return {
  'laytan/cloak.nvim',
  keys = require('tima.mappings.cloak'),
  event = { 'BufReadPre', 'BufNewFile' },
  config = function() require('tima.configs.cloak') end,
}
