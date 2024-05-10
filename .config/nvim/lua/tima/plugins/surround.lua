return {
  'kylechui/nvim-surround',
  keys = { 'cs', 'ys', 'ds', { 'S', mode = 'v' }, },
  config = function() require 'nvim-surround'.setup() end,
}
