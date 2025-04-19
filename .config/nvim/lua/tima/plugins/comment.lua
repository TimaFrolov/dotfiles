return {
  'numToStr/Comment.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function() require('tima.configs.comment') end,
}
