return {
  'numToStr/Comment.nvim',
  keys = { { "<leader>c", mode = { 'n', 'v' } } },
  config = function() require 'tima.configs.comment' end,
}
